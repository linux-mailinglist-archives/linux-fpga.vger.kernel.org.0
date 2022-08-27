Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FBB5A37C8
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Aug 2022 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiH0NE4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Aug 2022 09:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiH0NEl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 27 Aug 2022 09:04:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0A58B55;
        Sat, 27 Aug 2022 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661605477; x=1693141477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2eXGrAiHgrEugs9M07n6mJPYWQ0x9mmQvYK4n6HubU4=;
  b=hdTwDQWuyR6w3wvlGglOfvyyP/aQNNl86X24nDPimk40gFCvkYnv6taJ
   i4yu8MhAWRANXB7a3pfPVyzsyMpTkrrjR495VFLaqw37jXY69Ryi61Fz1
   R6oNWX9IvvYhmmqiiRXYW8oZ6a8bhSLt97aiuU4/cU54+4O7cfZi1UHDj
   JaR5udxxERgb54JrPoRVr8aJwV8UgfEws/mNUP/JDC8SZWIylo8286J+Q
   0VM2C38zgPLPo4F6fThVoPXXK3KKsYgJ/nB8oIvZwCJRrbewgmcmIN5Nr
   LSttQb/qX+FaRRsdH+rVYmFd3Y7h1rlkVFAExBJT3Uv/c06xm6jth3KDl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="358627772"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="358627772"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 06:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="640388813"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2022 06:04:33 -0700
Date:   Sat, 27 Aug 2022 20:55:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/fpga: fix repeated words in comments
Message-ID: <YwoUNXCwsq2tBE3F@yilunxu-OptiPlex-7050>
References: <20220825123803.13979-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825123803.13979-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-25 at 20:38:03 +0800, Jilin Yuan wrote:
>  Delete the redundant word 'if'.

No indentation please.

And please fix the subject, "fpga: stratix10-soc:" please

Thanks,
Yilun

> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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
> 2.36.1
> 
