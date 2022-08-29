Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2DC5A40CE
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Aug 2022 03:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiH2BvR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Aug 2022 21:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH2BvR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 28 Aug 2022 21:51:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E31165B4
        for <linux-fpga@vger.kernel.org>; Sun, 28 Aug 2022 18:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661737876; x=1693273876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mg99E+a+pS04NHudO3LxuzkViL3DrI8L+gTDzVS+0Gk=;
  b=aKR7Ja/mg/hOg3MmGpLFTLHgrM2IzXUUgRLh2gr6fdp3L5zVz22mY2Zt
   4YNrunCWAjGWfNgddHnhfXLpLs2OHPynI/oPVrEaMLVkF0pFznSiSip1u
   Tu5aIttlHhJdCMUXrTN0EQSiT4o8yFnfGK2L1jOzMeNFKJFCcTAxaJLEo
   PKq98aoRYfTJMu08Ocyk0pWgkCE+UbR1Q6/PeriES8sEWYjXUY62cOv2m
   rKsAvaRXtKGem3CS/geOvGvjCnVgknStCxzW/D3f1PKFlv8CXm4oyfl76
   j7lkdV2Im9fv1Rf9SgsiEX6uBHtDixOrXP6IC2ZLeOOfyjmqEkuOAZmSG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="275191752"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="275191752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 18:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="640740894"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2022 18:51:14 -0700
Date:   Mon, 29 Aug 2022 09:41:56 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Conor.Dooley@microchip.com
Cc:     dengshaomin@cdjrlc.com, mdf@kernel.org, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, trix@redhat.com
Subject: Re: [PATCH] fpga: stratix10-soc: Fix comments typo
Message-ID: <YwwZZNeKiW7yA6n8@yilunxu-OptiPlex-7050>
References: <20220825144155.2345-1-dengshaomin@cdjrlc.com>
 <YwoorTXmTwOFfIwz@yilunxu-OptiPlex-7050>
 <f6a0b8a7-99cc-0974-564c-f2a215b5fc26@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a0b8a7-99cc-0974-564c-f2a215b5fc26@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-27 at 14:46:37 +0000, Conor.Dooley@microchip.com wrote:
> On 27/08/2022 15:22, Xu Yilun wrote:
> > On 2022-08-25 at 10:41:55 -0400, Shaomin Deng wrote:
> >> Delete the repeated word "if" in comments.
> > 
> > Please don't duplicate similar patches.
> 
> It probably is not the right fix either...
> 
> > 
> >>
> >> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> >> ---
> >>  drivers/fpga/stratix10-soc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> >> index 357cea58ec98..e4f2e83a615b 100644
> >> --- a/drivers/fpga/stratix10-soc.c
> >> +++ b/drivers/fpga/stratix10-soc.c
> >> @@ -285,7 +285,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
> >>  
> >>  	/*
> >>  	 * Loop waiting for buffers to be returned.  When a buffer is returned,
> >> -	 * reuse it to send more data or free if if all data has been sent.
> >> +	 * reuse it to send more data or free if all data has been sent.
> 
> s/free if if/free it if

You are right. Thanks for your review.

> 
> Not sure if the cdjrlc people are scripting these duplicate word removals
> but if so, they should check the output before sending b/c this seems to
> happen a lot.

They should. Scripting patches and sent without check is actually not a
good idea.

Thanks,
Yilun

> 
> Thanks,
> Conor.
> 
> >>  	 */
> >>  	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
> >>  		reinit_completion(&priv->status_return_completion);
> >> -- 
> >> 2.35.1
> >>
