Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9B542751
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Jun 2022 09:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiFHGzJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Jun 2022 02:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346882AbiFHF5k (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Jun 2022 01:57:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96FC2F297D;
        Tue,  7 Jun 2022 21:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654661911; x=1686197911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hxwdLYtFn89/HjO6XjPYgmI2YT0p6JagRAg+2psMSkI=;
  b=Pk9kTC4l/h8EuOtq2HFZaupyWzGkAKiCo0fc+f63j5wSu/hwA8RQc9dl
   ayfgr/rB4FbrKc55W7RcHjMfcvjW5EJlQ2Rtkr7JJyXoL+uJiRqd3bQA8
   ladigZJj1d2wnB8p9r/aM3DpI+Ylq+9JplB2vnBLktDCSnYrIRw0uvhxm
   c30ZWQMgrNaBPRfnkIntBq1hsekpj9tV17Fp6QTygL2W6ORI9C1qrVYYc
   l0jnOCqaF2gcpdEp+AyizmLNRgfmmMhfls/bIg9Cxm2kfJ51Z4QlH6PKG
   BiY/RjWJtOPkIpHnLX+OZdYaHtOC68fI6YaoT56I+7j5TdtTM3UfABcxt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277567954"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="277567954"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 21:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636539783"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2022 21:18:24 -0700
Date:   Wed, 8 Jun 2022 12:10:30 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: altera-pr-ip: fix unsigned comparison with less
 than zero
Message-ID: <20220608041030.GA407787@yilunxu-OptiPlex-7050>
References: <20220525151453.55725-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525151453.55725-1-marpagan@redhat.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 25, 2022 at 05:14:52PM +0200, Marco Pagani wrote:
> Fix the "comparison with less than zero" warning reported by
> cppcheck for the unsigned (size_t) parameter count of the
> alt_pr_fpga_write() function.
> 

Please add the 'Fixes' tag, and resend it based on 5.19-rc1

Thanks,
Yilun

> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
> Changes v1 -> v2:
> - Coding style fix
> ---
>  drivers/fpga/altera-pr-ip-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index be0667968d33..df8671af4a92 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
>  	u32 *buffer_32 = (u32 *)buf;
>  	size_t i = 0;
>  
> -	if (count <= 0)
> +	if (!count)
>  		return -EINVAL;
>  
>  	/* Write out the complete 32-bit chunks */
> -- 
> 2.35.3
