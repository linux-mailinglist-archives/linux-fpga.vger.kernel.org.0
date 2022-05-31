Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972E25389BC
	for <lists+linux-fpga@lfdr.de>; Tue, 31 May 2022 03:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbiEaByU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 May 2022 21:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiEaByU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 May 2022 21:54:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531E49154B;
        Mon, 30 May 2022 18:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653962059; x=1685498059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=44vXxp+FvrSv8EIDNXaoCaZ3wwjaHpaOZhjvW3J5+Fk=;
  b=JMk+6VsxFRV3roHHho3MqUSlXAQ/HxGVWOh9YYfQroq3ZjjCwVSRoT8g
   p0b+uDa+9a4VPP9iTcpfzVmbCUF/n4J0vcUevX/se0yUwQISxZO1/LelE
   GcrZUmHY2Y6fAG4esJOnk0p74Ch61o7S3dn4fkCeLI8uFuqROC5vL2LdS
   hYR6zJmcQ3uo5mhVRm+m8hf2Pxezqq7R31hyCXEc/AdVxvYo/YVbrxCe2
   nRAFlvq4KYuQ5+1sK4wfWj7AQEJFLLu/Dmv/0FxkQhXd/oc8aL6ePzj64
   CREKi+sZ8ZLWJfAQoXc5Epv6nvGJ4pSQT10qEKG2hfLZtdKYeCiqLF5Py
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="254984565"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="254984565"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 18:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="529360663"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2022 18:54:16 -0700
From:   tien.sung.ang@intel.com
To:     yilun.xu@intel.com
Cc:     christophe.jaillet@wanadoo.fr, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, tien.sung.ang@intel.com, trix@redhat.com
Subject: Re: [PATCH v2] fpga: altera-cvp: Truncated bitstream error support
Date:   Tue, 31 May 2022 09:53:56 +0800
Message-Id: <20220531015356.2305182-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220528095933.GB175008@yilunxu-OptiPlex-7050>
References: <20220528095933.GB175008@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

hi,

I will fix the "blank line" issues. 

>> The current AIB CvP firmware is not capable of handling a
>> data stream smaller than 4096bytes. The firmware's limitation

>So why don't you check the image size on write_init(), and just prevent
>the DMA writing at the very beginning?
We try not to add any kind of logic in the CvP driver to read
or understand the correctness of the bitstream. In future, this
logic may change. The CvP driver to our best interest should
only be responsible to perform the transfer of the bitstream
and perform the respective handshake. We have plans to have
the CvP firmware on the other side be more intelligent to 
handle errors and inform the CvP driver on why a certain 
configuration session fails. We are in the process of making
the next generation CvP to close this gaps.

>> To resolve this design limitation, both firmware and CvP
>> driver made several changes. At the CvP driver, we just
>> have to ensure that anything lesser than 4096bytes are
>> padded with extra bytes. The CvP will then, initiate the
>> tear-down by clearing the START_XFER and CVP_CONFIG bits.

> The driver pads the data block to 4096 bytes, then why the CvP still
> should fail the reprograming?
The block size of 4096bytes containts headers and signatures that
comprise a bitstream to FPGA. Any of the missing pieces will 
cause the FPGA configuration to fail at the SDM (Secure device
manager). We are at Intel are just trying to avoid a user from
using a bad data to reconfigure the FPGA via CvP and then, hitting
into a fault that is non-recoverable. Only a hard-reboot of the 
entire system can undo it. 

> If the image size is larger than 1 Page but is not aligned to 1 Page,
> will the reprogramming still fail?
Yes, the reconfiguration will fail. The above tear-down  is to prevent
that CvP Hardware/firmware in the FPGA from entering into a dead-lock.


>> +		memcpy(conf->send_buf, data, len);

>Any padding value is OK?
Yes, any padding value is fine. The reason for this is that, the
CvP Firmware/Hardware on the other side is using DMA to perform
transfers of 4096bytes. The firmware will wait forever for the
DMA to complete. The firmware is not able to check for status
or respond to any errors while in the wait state. 

>> +		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
>> +				      conf->priv->block_size);

>If the len equals block_size, is the copy still needed?
Actually, not required. But to maintain a simple design, we use
a common flow for all so you can skip the check.

>> +	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
>> +	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
>> +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR!\n");

>So this new error checking covers the previous "latched error" case?
Yes, because the new feature requires for the CvP driver to 
be able to subsequently re-perform a fresh new CvP session after
an error. With the above, the CvP driver will forever report
an error and caused the entire CvP to be permanently in error. 
This is not desirable and the user would need to power-cycle the
or hard reboot the entire system to recover. Intel sees this as
a terrible user-experience espcially as CvP is performed 
normally remotely.

>> +	/* Allocate the 4096 block size transmit buffer */
>> +	conf->send_buf = devm_kzalloc(&pdev->dev, conf->priv->block_size, GFP_KERNEL);

>If block_size == ALTERA_CVP_V1_SIZE, the copy is still needed?
Yes, the firmware and hardware on the other side uses DMA
and V1 to my understanding has a smaller buffer size. Intel 
later improved this and introduced a new back-pressure credit 
data flow control to help increase the performance.

>> +	if (!conf->send_buf) {
>> +		ret = -ENOMEM;
>> +		goto err_unmap;
>> +	}

>Maybe it is better move the buffer allocation to write_init()
The altera_cvp_conf has not been created yet at this point.
The init routine in CvP so far just registers the driver.

