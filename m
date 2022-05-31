Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966305389E4
	for <lists+linux-fpga@lfdr.de>; Tue, 31 May 2022 04:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbiEaCUe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 May 2022 22:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiEaCUc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 May 2022 22:20:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D5D8CCE4;
        Mon, 30 May 2022 19:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653963631; x=1685499631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tsp2Js378HnMxOjZEQEeYwhoUZhRQiZFihQ/jcFVWAE=;
  b=gybibPWplaO42sU9a4avqrQyfqPlpufxVALjBR70cmlKWJ6Ip0I3C724
   6UvwDL5vvMlaHkmpFPFZqnLSSLLMsY+2Vf2Apuzj8LEk8jeylUgto9gTA
   4v3Lpz4AppJryWcXGkxcy2EglatY/YNQZI9HzR/jgt/EbXooTBK4ZPW73
   JV4HuUCgE/YoWAo23oCbUKcXH4aJRBX70s+hUkvBkV8a4yI4k/Vj8jhVu
   ngpN4f5oYuDdd0aUQGcK2WGyFZoGV0vJBYcT7LIclCcipCXAI83hNqWxZ
   o66ltQlXBdrgJU0ExDxAmHYMq8qtLn6vMf0O4L8JnzOgs5n8errAzsBJB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="275202185"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="275202185"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 19:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="720103698"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2022 19:20:29 -0700
From:   tien.sung.ang@intel.com
To:     yilun.xu@intel.com
Cc:     dinh.nguyen@intel.com, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, tien.sung.ang@intel.com, trix@redhat.com
Subject: Re: [PATCH] fpga: altera-cvp: allow interrupt to continue next time
Date:   Tue, 31 May 2022 10:20:04 +0800
Message-Id: <20220531022004.2314963-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220528120400.GA175058@yilunxu-OptiPlex-7050>
References: <20220528120400.GA175058@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

>> CFG_READY signal/bit may time-out due to firmware not responding
>> within the given time-out. This time varies due to numerous
>> factors like size of bitstream and others.
>> This time-out error does not impact the result of the CvP
>> previous transactions. The CvP driver shall then, respond with

>Do you mean the reprogramming is successful even if you find the time
>out in write_complete()? Then return 0 is better?
Based on the information given by the Intel FPGA firmware team,
CFG_READY is essential to indicate if the current FPGA 
configuration session is indeed a success. There are 
cases we test in the lab whereby, CFG_READY stays invalid and
the tests performed subsequently to verify the FPGA functionality
could not detect the failed session. A failed FPGA 
configuration session means, the new bitstream wasn't 
successfully configured and tests ran later will just be passing
on the previous working bitstream version. In short, CFG_READY
is esential, and an error indicating the time-out is a must.
Another example, using an incorrect SOF/Design FPGA results
in CFG_READY being invalid. The user must be informed of a 
potential error. 
I will correct the wordings i used earlier that says that
the timoeut error does not impact the results of the CvP
previous transactions. It may so if the firmware has some sort
of error. 

>And could you specify what the time-out mean on write_init() phase?
I could not really understand your question. We set huge 
time-outs of ~10seconds. Every wait for the firmware to respond
is potentially a hazard. The firmware CvP is has it's limitation
unfortunately. 

