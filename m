Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94A96BF942
	for <lists+linux-fpga@lfdr.de>; Sat, 18 Mar 2023 11:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjCRJ74 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 18 Mar 2023 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCRJ7z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 18 Mar 2023 05:59:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E431367E2;
        Sat, 18 Mar 2023 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679133594; x=1710669594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rqzxt1VGupOEfYGONcYiToQW8wfRtVs/qcIF0suXze8=;
  b=P55ym5g7WeZnFEABgFdls/g7Rrbl6KC4QPnehVqtE6a9wGSEaTOSqmNl
   /F5+blLpHhdVl3vZLo0HeRQs0qyfo2gFJF8w8pV0np8t9TJAG6PJMAEZE
   u5rtEahKpQgWCia0inLokBNM01W+ZzAaQt9aEBclZkZHF7ghhydL317Ct
   RxFw4a4dnpRYmlx0ZhKVDk5h/XRBP/FlrOaQNzjM/pJgxuERZUdSTAu6D
   SmCnwuShRHNg4Gd76HIGNglM0VjgsxDOq3+gsLYWfQEAmO7IBGx8MX8jj
   wO4S2BMM4LvMaXwqaQTHvU3VF6tNc7yd3Kxxy4RXZ1uUuAj5tIsi7vue3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="326786538"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="326786538"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 02:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="804381771"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="804381771"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2023 02:59:50 -0700
Date:   Sat, 18 Mar 2023 17:48:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq: Add parse_header ops support
Message-ID: <ZBWI7TrwssjjRsc9@yilunxu-OptiPlex-7050>
References: <20230314121754.297264-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314121754.297264-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-14 at 17:47:54 +0530, Nava kishore Manne wrote:
> The commit 3cc624beba63 ("fpga: fpga-mgr: support bitstream offset in
> image buffer") added a new parse_header ops to handle the header related
> stuff in the fpga framework. So moved the header validation logic from
> write_init() to parse_header().
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  drivers/fpga/zynq-fpga.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index ae0da361e6c6..6e5df0193028 100644
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
> +		if (!zynq_fpga_has_sync(buf, count)) {

FPGA manager may pass in the whole image if it is already mapped, maybe
only info->header_size should be checked?

Thanks,
Yilun

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
