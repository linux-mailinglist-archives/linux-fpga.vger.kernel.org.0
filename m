Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27142522DCA
	for <lists+linux-fpga@lfdr.de>; Wed, 11 May 2022 10:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiEKH63 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 May 2022 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiEKH60 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 11 May 2022 03:58:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA75045C;
        Wed, 11 May 2022 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652255904; x=1683791904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=etfXY7aRBHWY1zrZQ6x+4EO2EbvNrfvGqvu3EERCjPA=;
  b=WNs7wSMyUdMx5cvAEZK/KBD7974bGmCI+2gc7dHfqVngdiSKaQs7k5Ro
   FLacMs4qrHdXDyAk+5AQHpAGrkKciE5tcrKOc1eOyj15MJe0Zy77FghQS
   rAa8cilpxPM/FSop8Pb6fiLac7Nc1duJYunn3c/B1u1Zm1KQxcDfyyLGR
   qCS3r0Pe+49NVkG6AX5x5fcHkK1qXlwGIXGQgLNDIi1Gag8dRz9IfQLjv
   ON2xZl4irxCnRR7fQRwsYlOgy9qUGNIAvlwMKLJwvV/ztHtgrpCHp6QCo
   9wty94lkGEHv6w/po7YAgwKppklI6FWYUHVd4+NPQIPglxd9gloVyWF3R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="257166209"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="257166209"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="739105935"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2022 00:58:21 -0700
Date:   Wed, 11 May 2022 15:50:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Alan Tull <atull@kernel.org>, Shiva Rao <shiva.rao@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: Fix memory leak in build_info_create_dev
Message-ID: <20220511075023.GA487046@yilunxu-OptiPlex-7050>
References: <20220511064400.63518-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511064400.63518-1-linmq006@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 11, 2022 at 10:44:00AM +0400, Miaoqian Lin wrote:
> platform_device_alloc() create a platform device object.
> we should call platform_device_put() in error path to
> release the resource.
> 
> Fixes: 543be3d8c999 ("fpga: add device feature list support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/fpga/dfl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..f0b945bd975f 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -879,8 +879,10 @@ build_info_create_dev(struct build_feature_devs_info *binfo,
>  	INIT_LIST_HEAD(&binfo->sub_features);
>  
>  	fdev->id = dfl_id_alloc(type, &fdev->dev);
> -	if (fdev->id < 0)
> +	if (fdev->id < 0) {
> +		platform_device_put(fdev);
>  		return fdev->id;
> +	}

The build_info_free() will finally put the fdev, is it?

Thanks
Yilun

>  
>  	fdev->dev.parent = &binfo->cdev->region->dev;
>  	fdev->dev.devt = dfl_get_devt(dfl_devs[type].devt_type, fdev->id);
> -- 
> 2.25.1
