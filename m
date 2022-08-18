Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A867597D79
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Aug 2022 06:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbiHRE1O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Aug 2022 00:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243211AbiHRE1N (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 18 Aug 2022 00:27:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C25F31207;
        Wed, 17 Aug 2022 21:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660796832; x=1692332832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S+SgNVUGjPilD/TcMMolv5HajrqXFmE5M8AKXXkENE4=;
  b=fQu4HwP9mca2fecH4sZVHE5pGAts1v7KL0a0T9CERbXVwz+gMTrtpwxq
   yJNfUZ1RFdTFeFtUxFGF9/vz60arjJCXnb27a7pkynja8NblQQjSzXH2V
   ZTMeUJHjL8Tm14IM//cxDud5Bx+FVsKZu1gGD4M1v83ObdeCr8V/dwdTG
   gWmJcBwaHwUB+KFv38UXNTazq2WfKfadYJ7rwm4IePN4seO9qfpmsuM7n
   BUQ8dadHIJnuvWnb6ngxbKyCE0uFuJb+E/qyeltIgDJLuGbk5uAjXwtwn
   c5hhJH0UzcSt/KaN5e0NfpABKWcfesXS0juk/fJ/hjkDprloZYfQ/BLlD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="354401921"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="354401921"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 21:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="667923312"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2022 21:27:09 -0700
Date:   Thu, 18 Aug 2022 12:18:02 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Peter Colberg <peter.colberg@intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com
Subject: Re: [PATCH v1] uio: dfl: add IOPLL user-clock feature id
Message-ID: <Yv29ev8OKyEYcaf/@yilunxu-OptiPlex-7050>
References: <20220817213746.4986-1-peter.colberg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817213746.4986-1-peter.colberg@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-17 at 17:37:46 -0400, Peter Colberg wrote:
> Add a Device Feature List (DFL) feature id for the configurable
> IOPLL user clock source, which can be used to configure the clock
> speeds that are used for RTL logic that is programmed into the
> Partial Reconfiguration (PR) region of an FPGA.

Why not use linux clock framework for this IOPLL? And let the PR
driver set it togeter with the RTL logic reporgramming?

Thanks,
Yilun

> 
> The DFL feature id table can be found at:
> https://github.com/OPAE/dfl-feature-id
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
>  drivers/uio/uio_dfl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> index 8f39cc8bb034..69e93f3e7faf 100644
> --- a/drivers/uio/uio_dfl.c
> +++ b/drivers/uio/uio_dfl.c
> @@ -46,10 +46,12 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>  
>  #define FME_FEATURE_ID_ETH_GROUP	0x10
>  #define FME_FEATURE_ID_HSSI_SUBSYS	0x15
> +#define PORT_FEATURE_ID_IOPLL_USRCLK	0x14
>  
>  static const struct dfl_device_id uio_dfl_ids[] = {
>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
>  	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
> +	{ PORT_ID, PORT_FEATURE_ID_IOPLL_USRCLK },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> -- 
> 2.28.0
> 
