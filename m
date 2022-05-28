Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92646536C6D
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiE1Kxe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiE1Kxd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 06:53:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175E1ADA7;
        Sat, 28 May 2022 03:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653735213; x=1685271213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y7R3+mu0g0HoCPlWfUYj/osjYVHe4Rcxmekmm9/hr3M=;
  b=J3vgYbhijVtwFh4+CnX4CgBdhI5e7SJ4xaj6ddI9lkAVC3bWF1w+qjuk
   tlBMVwp5Z7/2xL4xNECBUJq0XwnHTOLA161dhEO6a/T6qHx6FpJ1vQCeJ
   5OdJEFOA9dvx2y45abSESFY0UPothfTzGXd7p2p0wXb+ACaMd5dTvb3qy
   1Ans4z2M8vLNnsC3sQwPyuPtiyrjq7FE+c3cS1HlXe68mSUQMkAR8OuNS
   fhyGohe24tzBGbTR+i+WsXEaoi7KOZAQQXjiZVnpjzQYJboYppbSxZwDW
   BWETVCpo6O6iczt91kiSJsKgIMclFvtVgqfxn5zwmzBs3fj+VPg+CL6gY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274385436"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="274385436"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 03:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="575227591"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2022 03:53:30 -0700
Date:   Sat, 28 May 2022 18:45:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        tianfei.zhang@intel.com
Subject: Re: [PATCH 1/3] fpga: dfl: Fix kernel-doc warning in dfl.h for
 revision
Message-ID: <20220528104547.GA178479@yilunxu-OptiPlex-7050>
References: <20220519221249.858873-1-basheer.ahmed.muddebihal@linux.intel.com>
 <20220519221249.858873-2-basheer.ahmed.muddebihal@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519221249.858873-2-basheer.ahmed.muddebihal@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 19, 2022 at 03:12:47PM -0700, Basheer Ahmed Muddebihal wrote:
> Fixed the following warning:

Please help specify which tool reports this issue here. Is it lkp?

> drivers/fpga/dfl.h:255: warning: Function parameter or member 'revision' not described in 'dfl_feature'
> 

Please add the 'Fixes' tag here.
Please also add the 'Reported-by' tag here.

> Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> ---
>  drivers/fpga/dfl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 06cfcd5e84bb..766429e618f6 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -231,6 +231,7 @@ struct dfl_feature_irq_ctx {
>   *
>   * @dev: ptr to pdev of the feature device which has the sub feature.
>   * @id: sub feature id.
> + * @revision: sub feature revision.
>   * @resource_index: each sub feature has one mmio resource for its registers.
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s resources.
> -- 
> 2.34.1
