Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F98253F5C3
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jun 2022 07:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiFGFzu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Jun 2022 01:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiFGFzt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Jun 2022 01:55:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5086D4122;
        Mon,  6 Jun 2022 22:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654581348; x=1686117348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=blRvZhyRA1ZaOOrg6D578DFOBpuu1YgJkE3AGHxofgI=;
  b=GEQimPX2ZKgibeVK6rWacpAdw/G0k0PDrdnfUc3osLI/PSJ8smyxZNXf
   aWH0YXcjcKXN85W/BUztX5Rv2hAReWEna8YRl9CSl2ym3OL3MZUxuqJU8
   g1tIudQHpCn0DV+zA5NV5eMTFcfx6DVOQMgbjNbCH6RytpTKsZkik+wuE
   UtF2PdluXBWLoslNHkG5bEuFKpbxFy7qXSmY29A7s/2f0yoxNilNyxYEY
   gzZb+yuVxNI6zjcDrA1y2j1V3DgwBzxIEZM+txhRrK7osHiYK8TTx8xvW
   JLxzSdQvhoWz3WL/ghXVS0eahCnDUY2ebEb8frMVBE+NKmtGDqrRf7CMU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="274244630"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="274244630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 22:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="723182065"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2022 22:55:46 -0700
From:   tien.sung.ang@intel.com
To:     yilun.xu@intel.com
Cc:     christophe.jaillet@wanadoo.fr, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, tien.sung.ang@intel.com, trix@redhat.com
Subject: Re: [PATCH v2] fpga: altera-cvp: Truncated bitstream error support
Date:   Tue,  7 Jun 2022 13:55:30 +0800
Message-Id: <20220607055530.3755617-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603094911.GA238410@yilunxu-OptiPlex-7050>
References: <20220603094911.GA238410@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> But you are adding the logic in altera_cvp_write() to keep the
> correctness. What's the difference adding it somewhere else? And as I
> can see, preventing the writing at the very beginning is a much cleaner
> way.

Though without doubt, your solution is doable, I have a 
discussion with the Intel architect and they insisted that
the device driver must not make such a decision. The decision to 
drop or accept a transfer is up to the firmware. The firmware
insisted that the buffer be padded with whatever value. They
desire the transfer protocol to be obeyed to ensure, that 
there is no hard dependencies on the device driver if they
do one day change the 4kbytes to some other smaller value.

> > > If the image size is larger than 1 Page but is not aligned to 1 Page,
> > > will the reprogramming still fail?
> > Yes, the reconfiguration will fail. The above tear-down  is to prevent
> > that CvP Hardware/firmware in the FPGA from entering into a dead-lock.

> So if the image size is not aligned to 1 Page, the reprogram should fail
> anyway, is it? Then I really recommend you fail the reprogramming at the
> very beginning.

Same reasoning as above. We don't want the driver to make this
decision.

> > >> +		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
> > >> +				      conf->priv->block_size);
> > 
> > >If the len equals block_size, is the copy still needed?
> > Actually, not required. But to maintain a simple design, we use
> > a common flow for all so you can skip the check.

> I don't think so. We should make the code reasonable. Blindly copy the
> whole buffer impacts all normal cases, and makes people confused. The
> code seems shorter now, but not simpler, it takes people more time to
> figure out why.

Yes, it could look confusing to other programmers. And, yes, the 
padding doesn't matter. Let me relook into this. As the driver is 
already re-tested by the silicon validatioin. 
I want to avoid making any change as it
would meant another couple of weeks of re-testing. 
Can this be accepted as it is?

