Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD715A3820
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Aug 2022 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiH0Ob6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Aug 2022 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiH0Ob5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 27 Aug 2022 10:31:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8C6CD2B
        for <linux-fpga@vger.kernel.org>; Sat, 27 Aug 2022 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661610716; x=1693146716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MnBfp1E0rocBMl9ar4715W/Hddb/iCerOkXEs/ok3ws=;
  b=H/wUqHfAFoKDd4yOLzfOFmL4gyvTak3y5C9L0G0odrDgqpsBmVBN3TUX
   3XhyhDwW2A7FmdBX4OX5yGl7mpKWAMlkceUX5rqNCbvjYdibLaKuKUnCv
   bGWEiAaxNDlPBULVBEPG4GeEkrtqICVdgmVqydF8zHeTKi5gIxp0K13LU
   AbPaxOZe1X574fKY69gNNSCc1b01+WUwvA6gVFUcXd+i6J6vl0zpK6+RL
   llGgPNhoNAekN6RmmgfPBUcP1kLUJD1hoygwHuwYe+TzUZIuas9Sf2jWy
   2X1TZXyGYjM7Ziq0rHH1ChCeQStqcpPDTj9BJtNrKwB7TzCDubsayXmFr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="380970888"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="380970888"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 07:31:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="561742157"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2022 07:31:54 -0700
Date:   Sat, 27 Aug 2022 22:22:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, linux-fpga@vger.kernel.org,
        trix@redhat.com
Subject: Re: [PATCH] fpga: stratix10-soc: Fix comments typo
Message-ID: <YwoorTXmTwOFfIwz@yilunxu-OptiPlex-7050>
References: <20220825144155.2345-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825144155.2345-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-25 at 10:41:55 -0400, Shaomin Deng wrote:
> Delete the repeated word "if" in comments.

Please don't duplicate similar patches.

> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  drivers/fpga/stratix10-soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 357cea58ec98..e4f2e83a615b 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -285,7 +285,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  
>  	/*
>  	 * Loop waiting for buffers to be returned.  When a buffer is returned,
> -	 * reuse it to send more data or free if if all data has been sent.
> +	 * reuse it to send more data or free if all data has been sent.
>  	 */
>  	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
>  		reinit_completion(&priv->status_return_completion);
> -- 
> 2.35.1
> 
