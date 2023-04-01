Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A5B6D315F
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Apr 2023 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDAOdD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 1 Apr 2023 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDAOdC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 1 Apr 2023 10:33:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73BFC678;
        Sat,  1 Apr 2023 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680359581; x=1711895581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6ZyHKlSM/RWzkJaCnaHAvOC8U7nlGw+Qcy8Hciv6FE=;
  b=N2ONSdym/fpcBMx91t7paACIQXHES3taRvNY0yt2xno3oGQZrn7PVy9C
   IWaITWsp5RcAPnWNBFiQk/iwVq4SkuWl/SvwggPIT9Ex/4F7DC5z+pQpm
   vivOIh7vMCdvSvOb36nBpS7qca+R6+fWakwij8uyhBR+uvmqnUMl19EM4
   MnzxyIYh/mRuJIeAnk55X+KwIHvUTxWywp1/0K5G9qiUNWtqKdbS2gqZ5
   B1EfdJQQNFXdd1+mFCLxoniSKq3G34UXrDxnPKxyItQacCb9/9uEx3KnP
   Nt4Fm32tYZEsTBXYGeLPKJzoLVwZZ/wpK+ZOmjPn7XfSCeTt4KyzKWAvI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="341676923"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="341676923"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 07:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="829049450"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="829049450"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2023 07:32:59 -0700
Date:   Sat, 1 Apr 2023 22:21:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fpga: zynq: Add parse_header ops support
Message-ID: <ZCg95G5P2KMnjTcr@yilunxu-OptiPlex-7050>
References: <20230327122057.205123-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327122057.205123-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-27 at 17:50:57 +0530, Nava kishore Manne wrote:
> The commit 3cc624beba63 ("fpga: fpga-mgr: support bitstream offset in
> image buffer") added a new parse_header ops to handle the header related
> stuff in the fpga framework. So moved the header validation logic from
> write_init() to parse_header().

On second thought, I don't think the change is necessary. Implementing
parse_header only if the info->head/data_size needs runtime
re-evaluation according to the image. Otherwise, checking header in
write_init() is just fine.

Thanks,
Yilun

> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>               - Limit the sync pattern validation size to header_size
>                 as suggested Yilun.
> 
> Changes for v3:
>               - zynq_fpga_has_sync () API is expecting "u8 *". So type cast
>                 formal parameter "const char *" to "u8 *".
> 
>  drivers/fpga/zynq-fpga.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index ae0da361e6c6..a6096f0c93fc 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -248,6 +248,21 @@ static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
>  	return false;
>  }
>  
> +static int zynq_fpga_ops_parse_header(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info,
> +				      const char *buf, size_t count)
> +{
> +	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> +		if (!zynq_fpga_has_sync((u8 *)buf, info->header_size)) {
> +			dev_err(&mgr->dev,
> +				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swapped .bin file\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  				    struct fpga_image_info *info,
>  				    const char *buf, size_t count)
> @@ -275,13 +290,6 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  
>  	/* don't globally reset PL if we're doing partial reconfig */
>  	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> -		if (!zynq_fpga_has_sync(buf, count)) {
> -			dev_err(&mgr->dev,
> -				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swapped .bin file\n");
> -			err = -EINVAL;
> -			goto out_err;
> -		}
> -
>  		/* assert AXI interface resets */
>  		regmap_write(priv->slcr, SLCR_FPGA_RST_CTRL_OFFSET,
>  			     FPGA_RST_ALL_MASK);
> @@ -545,6 +553,7 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
>  static const struct fpga_manager_ops zynq_fpga_ops = {
>  	.initial_header_size = 128,
>  	.state = zynq_fpga_ops_state,
> +	.parse_header = zynq_fpga_ops_parse_header,
>  	.write_init = zynq_fpga_ops_write_init,
>  	.write_sg = zynq_fpga_ops_write,
>  	.write_complete = zynq_fpga_ops_write_complete,
> -- 
> 2.25.1
> 
