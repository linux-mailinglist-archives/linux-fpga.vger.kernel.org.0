Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C49D4FA4F6
	for <lists+linux-fpga@lfdr.de>; Sat,  9 Apr 2022 07:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiDIFN5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 9 Apr 2022 01:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiDIFNz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 9 Apr 2022 01:13:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93DF5E;
        Fri,  8 Apr 2022 22:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649481110; x=1681017110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2uEEnJaBm8W3hYNznIdKioT/aZO4ljgRCwHcLaiU/lc=;
  b=erQdJ5618afcriUXVQxl8l1BGHzotIsKyxUV4ttObG8VRtdDBbC2trXD
   fPJe189DQI35KWU69mTQ4r6Kb+MyQ84PRGY+8O3hxvrVTmEwrSTMRaJsL
   HyybidxO1eAAY+ba7lwHN0Kwf6QuhJs8Qx0iX514AHays2b7KGj6tdQ2H
   awoUfDCIQIdhz8Fy1fWIczkw5pPeODtUIPpdmkSEUZQaGUG0du9lOpAHt
   mWhMWN+QEpUeWL44AmFlVOZHPcSjP3AhlrF7tDMq7FmdWU3ttwTpzYfhC
   MQi0MTJwL3z2WpYNI9y4vUXXMw5/ZdMfi57znF8X/DaPpvgsXQKmgdnAv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="259358125"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="259358125"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 22:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="698498511"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 22:11:47 -0700
Date:   Sat, 9 Apr 2022 13:04:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/3] fpga: fpga-mgr: support bitstream offset in image
 buffer
Message-ID: <20220409050423.GA265355@yilunxu-OptiPlex-7050>
References: <20220407133658.15699-1-i.bornyakov@metrotek.ru>
 <20220407133658.15699-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407133658.15699-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 07, 2022 at 04:36:56PM +0300, Ivan Bornyakov wrote:
> It is not always whole FPGA image buffer meant to be written to the
> device.

Thanks for improving the fpga core. Please see my comments inline.

Maybe more description about the issue, i.e. in which case we don't
write the whole buffer, what's the problem in current implementation.

> 
> Add bitstream_start and bitstream_size to the fpga_image_info struct and
> adjust fpga_mgr_write() callers with respect to them.
> 
> If initial_header_size is not known beforehand, pass whole buffer to low
> level driver's write_init() so it could setup info->bitstream_start and
> info->bitstream_size regardless.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/fpga-mgr.c       | 48 +++++++++++++++++++++++++++++------
>  include/linux/fpga/fpga-mgr.h |  5 ++++
>  2 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index d49a9ce34568..c64e60e23a71 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -139,7 +139,8 @@ EXPORT_SYMBOL_GPL(fpga_image_info_free);
>   * Call the low level driver's write_init function.  This will do the
>   * device-specific things to get the FPGA into the state where it is ready to
>   * receive an FPGA image. The low level driver only gets to see the first
> - * initial_header_size bytes in the buffer.
> + * initial_header_size bytes in the buffer, if initial_header_size is set.
> + * Otherwise, the whole buffer will be passed.
>   */
>  static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  				   struct fpga_image_info *info,
> @@ -148,12 +149,10 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  	int ret;
>  
>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> -	if (!mgr->mops->initial_header_size)
> -		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
> -	else
> -		ret = fpga_mgr_write_init(
> -		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
> +	if (mgr->mops->initial_header_size)
> +		count = min(mgr->mops->initial_header_size, count);
>  
> +	ret = fpga_mgr_write_init(mgr, info, buf, count);

Here we pass the whole buffer for write_init(). Maybe it works for mapped buf,
but still doesn't work for sg buf.

It is also inefficient if we change to map and copy all sg buffers just for
write_init().

We could discuss on the solution.

My quick mind is we introduce an optional fpga_manager_ops.parse_header()
callback, and a header_size (dynamic header size) field in
fpga_image_info. FPGA core starts with mapping a buf of initial_header_size
for parse_header(), let the drivers decide the dynamic header_size.

The parse_header() could be called several times with updated dynamic
header_size, if drivers doesn't get enough buffer for final decision and
return -EAGAIN.

Then write_init() be called with the final dynamic header size.

For mapped buffer, just passing the whole buffer for write_init() is
fine.

>  	if (ret) {
>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
>  		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
> @@ -235,13 +234,33 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  	if (mgr->mops->write_sg) {
>  		ret = fpga_mgr_write_sg(mgr, sgt);
>  	} else {
> +		size_t offset, count, length, bitstream_size;
>  		struct sg_mapping_iter miter;
>  
> +		offset = info->bitstream_start;
> +		bitstream_size = info->bitstream_size;
> +		count = 0;
> +
>  		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
>  		while (sg_miter_next(&miter)) {
> -			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
> -			if (ret)
> +			if (offset >= miter.length) {
> +				offset -= miter.length;
> +				continue;
> +			}
> +
> +			if (bitstream_size)
> +				length = min(miter.length - offset,
> +					     bitstream_size - count);
> +			else
> +				length = miter.length - offset;
> +
> +			count += length;
> +
> +			ret = fpga_mgr_write(mgr, miter.addr + offset, length);
> +			if (ret || count == bitstream_size)
>  				break;
> +
> +			offset = 0;
>  		}
>  		sg_miter_stop(&miter);
>  	}
> @@ -265,6 +284,19 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
>  	if (ret)
>  		return ret;
>  
> +	if (info->bitstream_start > count) {
> +		dev_err(&mgr->dev,
> +			"Bitstream start %zd outruns firmware image %zd\n",
> +			info->bitstream_start, count);
> +		return -EINVAL;
> +	}
> +
> +	if (info->bitstream_size)
> +		count = min(info->bitstream_start + info->bitstream_size, count);
> +
> +	buf += info->bitstream_start;
> +	count -= info->bitstream_start;
> +
>  	/*
>  	 * Write the FPGA image to the FPGA.
>  	 */
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 0f9468771bb9..32464fd10cca 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -85,6 +85,9 @@ enum fpga_mgr_states {
>   * @sgt: scatter/gather table containing FPGA image
>   * @buf: contiguous buffer containing FPGA image
>   * @count: size of buf
> + * @bitstream_start: offset in image buffer where bitstream data starts
> + * @bitstream_size: size of bitstream.
> + *	If 0, (count - bitstream_start) will be used.
>   * @region_id: id of target region
>   * @dev: device that owns this
>   * @overlay: Device Tree overlay
> @@ -98,6 +101,8 @@ struct fpga_image_info {
>  	struct sg_table *sgt;
>  	const char *buf;
>  	size_t count;
> +	size_t bitstream_start;

How about we name it header_size?

> +	size_t bitstream_size;

And how about data_size?

Thanks,
Yilun

>  	int region_id;
>  	struct device *dev;
>  #ifdef CONFIG_OF
> -- 
> 2.25.1
> 
