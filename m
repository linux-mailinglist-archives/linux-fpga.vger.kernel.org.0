Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1631453033D
	for <lists+linux-fpga@lfdr.de>; Sun, 22 May 2022 15:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbiEVNJ3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 22 May 2022 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiEVNJ1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 22 May 2022 09:09:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE0A39834;
        Sun, 22 May 2022 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653224965; x=1684760965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JNi1rr7UsmJNPBUE1nqgoupvf0VeEmGT3KhKnKDQ6YI=;
  b=gZPvaeZsFKojYJ8lk2Nk7+5UiIFYzIxPtf0lyxiQqEIaWK84Uf6qf+5N
   pI9vViyJq1d8Y7g1yNx1T5UN9AINPcBPWXi1vCbS2nLmoeSEyBD1IM/ju
   qDYwvpFSV+1/dDyF9AxHDN4L06+KYprATDXqCn9hRWccVkPrAOYlX6mdC
   n60Q6pducvMvOKjrHHzVEXTtHyWykmW+hzANMtYMb5Mztawzcsja63UZR
   MDZJcQYzbsNdNGgcGUiCYsP2OAQvTbQxGALThTF/EQf84NQsadPKnldXS
   3xU2NQvdfcvS5rboFTUVZmzRVqW1Q9W3Fd5yIkA2CZyU2bVo/1tx+p4yR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="336046152"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="336046152"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 06:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="571622193"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 22 May 2022 06:09:22 -0700
Date:   Sun, 22 May 2022 21:01:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v12 1/3] fpga: fpga-mgr: support bitstream offset in
 image buffer
Message-ID: <20220522130145.GA89204@yilunxu-OptiPlex-7050>
References: <20220513162755.16201-1-i.bornyakov@metrotek.ru>
 <20220513162755.16201-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513162755.16201-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 13, 2022 at 07:27:53PM +0300, Ivan Bornyakov wrote:
> At the moment FPGA manager core loads to the device entire image
> provided to fpga_mgr_load(). But it is not always whole FPGA image
> buffer meant to be written to the device. In particular, .dat formatted
> image for Microchip MPF contains meta info in the header that is not
> meant to be written to the device. This is issue for those low level
> drivers that loads data to the device with write() fpga_manager_ops
> callback, since write() can be called in iterator over scatter-gather
> table, not only linear image buffer. On the other hand, write_sg()
> callback is provided with whole image in scatter-gather form and can
> decide itself which part should be sent to the device.
> 
> Add header_size and data_size to the fpga_image_info struct and adjust
> fpga_mgr_write() callers with respect to them.
> 
>   * info->header_size indicates part at the beginning of image buffer
>     that is *not* meant to be written to the device. It is optional and
>     can be 0.
> 
>   * info->data_size is the size of actual bitstream data that *is* meant
>     to be written to the device, starting at info->header_size from the
>     beginning of image buffer. It is also optional and can be 0, which
>     means bitstream data is up to the end of image buffer.
> 
> Also add parse_header() callback to fpga_manager_ops, which purpose is
> to set info->header_size and info->data_size. At least
> initial_header_size bytes of image buffer will be passed into
> parse_header() first time. If it is not enough, parse_header() should
> set desired size into info->header_size and return -EAGAIN, than it will
> be called again with greater part of image buffer on the input.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/fpga-mgr.c       | 150 ++++++++++++++++++++++++++--------
>  include/linux/fpga/fpga-mgr.h |  13 ++-
>  2 files changed, 127 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index a3595ecc3f79..c6ca395909a0 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -74,6 +74,15 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
>  	return 0;
>  }
>  
> +static inline int fpga_mgr_parse_header(struct fpga_manager *mgr,
> +					struct fpga_image_info *info,
> +					const char *buf, size_t count)
> +{
> +	if (buf && mgr->mops->parse_header)
> +		return mgr->mops->parse_header(mgr, info, buf, count);
> +	return 0;
> +}
> +
>  static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
>  				      struct fpga_image_info *info,
>  				      const char *buf, size_t count)
> @@ -136,32 +145,61 @@ void fpga_image_info_free(struct fpga_image_info *info)
>  EXPORT_SYMBOL_GPL(fpga_image_info_free);
>  
>  /*
> - * Call the low level driver's write_init function.  This will do the
> - * device-specific things to get the FPGA into the state where it is ready to
> - * receive an FPGA image. The low level driver only gets to see the first
> - * initial_header_size bytes in the buffer.
> + * Call the low level driver's parse_header then write_init functions.
> + * This will do the device-specific things to get the FPGA into the state
> + * where it is ready to receive an FPGA image. If parse_header sets
> + * info->header_size, the low level driver's write_init only gets to see the
> + * first info->header_size bytes in the buffer, mgr->mops->initial_header_size
> + * otherwise. If neither initial_header_size nor header_size are not set,
> + * write_init will not get any bytes of image buffer.

Could we always initialize the info->header_size = initial_header_size
at early stage, maybe in fpga_mgr_load(), and only query
info->header_size afterward. This is to make the logic for header size
simpler.

>   */
>  static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  				   struct fpga_image_info *info,
>  				   const char *buf, size_t count)
>  {
> +	size_t header_size;
>  	int ret;
>  
>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> -	if (!mgr->mops->initial_header_size) {
> -		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
> -	} else {
> -		count = min(mgr->mops->initial_header_size, count);
> -		ret = fpga_mgr_write_init(mgr, info, buf, count);
> +	ret = fpga_mgr_parse_header(mgr, info, buf, count);
> +	if (ret) {
> +		if (ret != -EAGAIN)
> +			dev_err(&mgr->dev,
> +				"Error while parsing FPGA image header\n");
> +
> +		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;

Could we move the header parsing out of fpga_mgr_write_init_buf()
and introduce a dedicated function fpga_mgr_parse_head_buf().
We could also define dedicated FPGA_MGR_STATE_PARSE_HEAD &
FPGA_MGR_STATE_PARSE_HEAD_ERR states. This is to makes the flow
more clear to developers. The sg_buf flow won't try several times
on write_init() actually.

> +		return ret;
>  	}
>  
> +	header_size = mgr->mops->initial_header_size;
> +	if (info->header_size)
> +		header_size = info->header_size;
> +
> +	ret = fpga_mgr_write_init(mgr, info, header_size ? buf : NULL, header_size);

We still need to check the count vs header_size, to ensure the low level
driver won't access buf out of bounds.

>  	if (ret) {
>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
>  		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
> -		return ret;
>  	}
>  
> -	return 0;
> +	return ret;
> +}
> +
> +static void *fpga_mgr_sgt_bounce_buf(struct sg_table *sgt, size_t count)
> +{
> +	size_t len;
> +	void *buf;
> +
> +	buf = kmalloc(count, GFP_KERNEL);
> +	if (!buf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf, count);
> +	if (len != count) {
> +		kfree(buf);
> +		return ERR_PTR(-EFAULT);
> +	}
> +
> +	return buf;
>  }
>  
>  static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
> @@ -169,37 +207,46 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,

Maybe we change the function name, I assume we should deal with
parse_image and write_init here. How about fpga_mgr_prepare_sg()?

>  				  struct sg_table *sgt)
>  {
>  	struct sg_mapping_iter miter;
> -	size_t len;
> +	size_t header_size;
>  	char *buf;
> -	int ret;
> +	int ret = -EAGAIN;
>  
> -	if (!mgr->mops->initial_header_size)
> +	header_size = mgr->mops->initial_header_size;
> +	if (!header_size)
>  		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
>  
> -	/*
> -	 * First try to use miter to map the first fragment to access the
> -	 * header, this is the typical path.
> -	 */
>  	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> -	if (sg_miter_next(&miter) &&
> -	    miter.length >= mgr->mops->initial_header_size) {
> -		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
> -					      miter.length);
> -		sg_miter_stop(&miter);
> -		return ret;
> +	if (!sg_miter_next(&miter)) {
> +		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
> +		ret = -EFAULT;
>  	}
> -	sg_miter_stop(&miter);
>  
> -	/* Otherwise copy the fragments into temporary memory. */
> -	buf = kmalloc(mgr->mops->initial_header_size, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +	while (ret == -EAGAIN) {

Is do ... while() better, then we don't have to initialize the ret = -EAGAIN.

> +		/*
> +		 * First try to use miter to map the first fragment to access
> +		 * the header, this is the typical path.
> +		 */
> +		if (miter.length >= header_size) {
> +			ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
> +						      miter.length);
> +		} else {
> +			/*
> +			 * Otherwise copy the fragments into temporary memory.
> +			 */
> +			buf = fpga_mgr_sgt_bounce_buf(sgt, header_size);
> +			if (IS_ERR(buf)) {
> +				mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
> +				ret = PTR_ERR(buf);
> +				break;
> +			}
>  
> -	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
> -				mgr->mops->initial_header_size);
> -	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
> +			ret = fpga_mgr_write_init_buf(mgr, info, buf, header_size);
> +			kfree(buf);
> +		}
>  
> -	kfree(buf);
> +		header_size = info->header_size;
> +	}
> +	sg_miter_stop(&miter);
>  
>  	return ret;
>  }
> @@ -236,13 +283,33 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  	if (mgr->mops->write_sg) {
>  		ret = fpga_mgr_write_sg(mgr, sgt);
>  	} else {
> +		size_t offset, count, length, data_size;
>  		struct sg_mapping_iter miter;
>  
> +		offset = info->header_size;
> +		data_size = info->data_size;
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
> +			if (data_size)
> +				length = min(miter.length - offset,
> +					     data_size - count);
> +			else
> +				length = miter.length - offset;
> +
> +			count += length;
> +
> +			ret = fpga_mgr_write(mgr, miter.addr + offset, length);
> +			if (ret || count == data_size)
>  				break;
> +
> +			offset = 0;

The logic for 'offset' is quite complex here.

Could we define a 'ssize count' and initialize as -(info->header_size)?
When 'count' becomes positive, we could start writing.

>  		}
>  		sg_miter_stop(&miter);
>  	}
> @@ -266,6 +333,19 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
>  	if (ret)
>  		return ret;
>  
> +	if (info->header_size + info->data_size > count) {
> +		dev_err(&mgr->dev, "Bitsream data outruns FPGA image\n");
> +		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
> +		return -EINVAL;
> +	}
> +
> +	if (info->data_size)
> +		count = info->data_size;
> +	else
> +		count -= info->header_size;
> +
> +	buf += info->header_size;
> +
>  	/*
>  	 * Write the FPGA image to the FPGA.
>  	 */
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 0f9468771bb9..a49b97bccfa2 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -85,6 +85,8 @@ enum fpga_mgr_states {
>   * @sgt: scatter/gather table containing FPGA image
>   * @buf: contiguous buffer containing FPGA image
>   * @count: size of buf
> + * @header_size: offset in image buffer where bitstream data starts
> + * @data_size: size of bitstream. If 0, (count - header_size) will be used.
>   * @region_id: id of target region
>   * @dev: device that owns this
>   * @overlay: Device Tree overlay
> @@ -98,6 +100,8 @@ struct fpga_image_info {
>  	struct sg_table *sgt;
>  	const char *buf;
>  	size_t count;
> +	size_t header_size;
> +	size_t data_size;
>  	int region_id;
>  	struct device *dev;
>  #ifdef CONFIG_OF
> @@ -137,9 +141,13 @@ struct fpga_manager_info {
>  
>  /**
>   * struct fpga_manager_ops - ops for low level fpga manager drivers
> - * @initial_header_size: Maximum number of bytes that should be passed into write_init
> + * @initial_header_size: minimum number of bytes that should be passed into
> + *	parse_header and write_init.
>   * @state: returns an enum value of the FPGA's state
>   * @status: returns status of the FPGA, including reconfiguration error code
> + * @parse_header: parse FPGA image header to set info->header_size and
> + *	info->data_size. In case the input buffer is not large enough, set
> + *	requierd size to info->header_size and return -EAGAIN.

	required

Thanks,
Yilun

>   * @write_init: prepare the FPGA to receive configuration data
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
> @@ -155,6 +163,9 @@ struct fpga_manager_ops {
>  	size_t initial_header_size;
>  	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
>  	u64 (*status)(struct fpga_manager *mgr);
> +	int (*parse_header)(struct fpga_manager *mgr,
> +			    struct fpga_image_info *info,
> +			    const char *buf, size_t count);
>  	int (*write_init)(struct fpga_manager *mgr,
>  			  struct fpga_image_info *info,
>  			  const char *buf, size_t count);
> -- 
> 2.35.1
> 
