Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD15370F3
	for <lists+linux-fpga@lfdr.de>; Sun, 29 May 2022 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiE2MfI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 May 2022 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiE2MfE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 May 2022 08:35:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA84A98088;
        Sun, 29 May 2022 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653827699; x=1685363699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lDy0i9XvwRaRAd438BRHVsh0BPm5tTW2JNo5WJOGbxs=;
  b=joOr99OLiEler1zNupGkIuBzwlnq8Rs9Ifm4K5WBdAKXfda/CspH6acH
   5aKwPgR4PfTj5qLQ9L2IdMutM/nQj6jagSldyKN5EmWKDUPiSWhoNIYDI
   07KbaL2HBnvHSPCniRcEIxwkOz05IQj2fKdDU2t50zeIrDAh0/O80YbR6
   R/qL3CL3Pv2cfRa2zKJ6Lg47/ghSrJYj1xb6H93gq1/TwxaHEPZ9QFwKI
   q6gmGr7GzVkL5ehb3VD3TM/LaXwV2pf0GCnJxHq5bN8Qr1jaEi57Q7led
   RclR5wt3dX3/UfJXZK2f9g9dKAIILRdMR5Vi7pl1f2uMTQ6kQ9O2x1XQe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="361172702"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="361172702"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 05:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="604735254"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 29 May 2022 05:34:55 -0700
Date:   Sun, 29 May 2022 20:27:11 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v13 1/3] fpga: fpga-mgr: support bitstream offset in
 image buffer
Message-ID: <20220529122711.GA185904@yilunxu-OptiPlex-7050>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526181344.2088-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 26, 2022 at 09:13:42PM +0300, Ivan Bornyakov wrote:
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
> set desired size into info->header_size and return -EAGAIN, then it will
> be called again with greater part of image buffer on the input.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/fpga-mgr.c       | 174 ++++++++++++++++++++++++++++------
>  include/linux/fpga/fpga-mgr.h |  17 +++-
>  2 files changed, 159 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index a3595ecc3f79..7adca88c68a0 100644
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
> +	if (mgr->mops->parse_header)
> +		return mgr->mops->parse_header(mgr, info, buf, count);
> +	return 0;
> +}
> +
>  static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
>  				      struct fpga_image_info *info,
>  				      const char *buf, size_t count)
> @@ -136,44 +145,78 @@ void fpga_image_info_free(struct fpga_image_info *info)
>  EXPORT_SYMBOL_GPL(fpga_image_info_free);
>  
>  /*
> - * Call the low level driver's write_init function.  This will do the
> + * Call the low level driver's parse_header function. This will set
> + * info->header_size and info->data_size. The low level driver gets entire
> + * buffer provided. If it is not enough, driver should set desired size into
> + * info->header_size and return -EAGAIN, then parse_header() will be called
> + * again with greater part of image buffer on the input.
> + */
> +static int fpga_mgr_parse_header_buf(struct fpga_manager *mgr,
> +				     struct fpga_image_info *info,
> +				     const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> +	ret = fpga_mgr_parse_header(mgr, info, buf, count);
> +	if (ret) {
> +		if (ret != -EAGAIN)
> +			dev_err(&mgr->dev,
> +				"Error while parsing FPGA image header\n");
> +
> +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;

If ret == EAGAIN, don't set the state to ERROR.

> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Call the low level driver's write_init function. This will do the
>   * device-specific things to get the FPGA into the state where it is ready to
> - * receive an FPGA image. The low level driver only gets to see the first
> - * initial_header_size bytes in the buffer.
> + * receive an FPGA image. If info->header_size is defined, the low level
> + * driver only gets to see the first info->header_size bytes in the buffer,
> + * mgr->mops->initial_header_size otherwise. If neither initial_header_size
> + * nor header_size are not set, write_init will not get any bytes of image
> + * buffer.
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
> -	}
> +
> +	header_size = mgr->mops->initial_header_size;
> +	if (info->header_size)
> +		header_size = info->header_size;

How about:

	if (info->header_size)
		header_size = info->header_size;
	else
		header_size = mgr->mops->initial_header_size;

> +
> +	if (header_size > count)
> +		ret = -EINVAL;
> +	else
> +		ret = fpga_mgr_write_init(mgr, info, header_size ? buf : NULL,

Don't abuse ternary operator, the original code style is fine.

> +					  header_size);

Maybe 'count' is better than 'header_size' here?

So how about:

	if (header_size > count)
		ret = -EINVAL;
	else if (!header_size)
		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
	else
		ret = fpga_mgr_write_init(mgr, info, buf, count);

>  
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
>  		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
> -		return ret;
>  	}
>  
> -	return 0;
> +	return ret;

I assume it's just code style change, not needed in this patch.

>  }
>  
> -static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
> -				  struct fpga_image_info *info,
> -				  struct sg_table *sgt)
> +static int fpga_mgr_prepare_sg(struct fpga_manager *mgr,
> +			       struct fpga_image_info *info,
> +			       struct sg_table *sgt)
>  {
>  	struct sg_mapping_iter miter;
> -	size_t len;
> +	size_t header_size, len;
>  	char *buf;
>  	int ret;
>  
> -	if (!mgr->mops->initial_header_size)
> +	header_size = mgr->mops->initial_header_size;
> +	if (!header_size)
>  		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
>  
>  	/*
> @@ -182,24 +225,41 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
>  	 */
>  	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
>  	if (sg_miter_next(&miter) &&
> -	    miter.length >= mgr->mops->initial_header_size) {
> -		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
> -					      miter.length);
> -		sg_miter_stop(&miter);
> -		return ret;
> +	    miter.length >= header_size) {
> +		ret = fpga_mgr_parse_header_buf(mgr, info, miter.addr,
> +						miter.length);
> +		if (!ret)
> +			ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
> +						      miter.length);
> +
> +		if (ret != -EAGAIN) {

If fpga_mgr_write_init_buf() returns -EAGAIN, we may have trouble.

		ret = fpga_mgr_parse_header_buf(mgr, info, miter.addr,
						miter.length);
		/*
		 * If -EAGAIN, more sg buffer is needed, otherwise the
		 * flow would always endup in this branch.
		 */
		if (ret != -EAGAIN) {
			if (!ret)
				ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
							      miter.length);

			sg_miter_stop(&miter);
			return ret;
		}

> +			sg_miter_stop(&miter);
> +			return ret;
> +		}
>  	}
>  	sg_miter_stop(&miter);
>  
>  	/* Otherwise copy the fragments into temporary memory. */
> -	buf = kmalloc(mgr->mops->initial_header_size, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +	do {
> +		if (info->header_size)
> +			header_size = info->header_size;
> +
> +		buf = kmalloc(header_size, GFP_KERNEL);

Does krealloc() help?

> +		if (!buf)
> +			return -ENOMEM;
> +
> +		len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf, header_size);
> +		if (len != header_size) {
> +			kfree(buf);
> +			return -EFAULT;
> +		}
>  
> -	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
> -				mgr->mops->initial_header_size);
> -	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
> +		ret = fpga_mgr_parse_header_buf(mgr, info, buf, header_size);
> +		if (!ret)
> +			ret = fpga_mgr_write_init_buf(mgr, info, buf, header_size);

Same issue, fpga_mgr_write_init_buf may return -EAGAIN.

Please try to move fpga_mgr_write_init_buf() out of this loop.

>  
> -	kfree(buf);
> +		kfree(buf);
> +	} while (ret == -EAGAIN);
>  
>  	return ret;
>  }
> @@ -227,7 +287,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  {
>  	int ret;
>  
> -	ret = fpga_mgr_write_init_sg(mgr, info, sgt);
> +	ret = fpga_mgr_prepare_sg(mgr, info, sgt);
>  	if (ret)
>  		return ret;
>  
> @@ -237,11 +297,42 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  		ret = fpga_mgr_write_sg(mgr, sgt);
>  	} else {
>  		struct sg_mapping_iter miter;
> +		size_t length, data_size;
> +		ssize_t count;
> +		char *addr;
> +
> +		data_size = info->data_size;
> +		count = -info->header_size;
>  
>  		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
>  		while (sg_miter_next(&miter)) {
> -			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
> -			if (ret)
> +			if (-count >= miter.length) {
> +				count += miter.length;
> +				continue;
> +			}
> +
> +			if (count < 0) {
> +				addr = miter.addr - count;
> +
> +				if (data_size)
> +					length = min(miter.length + count,
> +						     data_size);
> +				else
> +					length = miter.length + count;
> +			} else {
> +				addr = miter.addr;
> +
> +				if (data_size)
> +					length = min(miter.length,
> +						     data_size - count);
> +				else
> +					length = miter.length;
> +			}
> +
> +			count += length;
> +
> +			ret = fpga_mgr_write(mgr, addr, length);
> +			if (ret || count == data_size)
>  				break;
>  		}

I think a negative initial value for count could simply the code:

Some code in my mind, please help check it:

		while (sg_miter_next(&miter)) {
			count += miter.length;

			/* sg block contains no data */
			if (count < 0)
				continue;

			if (count < miter.length) {
				/* sg block contains header & data */
				addr = miter.addr + miter.length - count;
				length = count;
			} else {
				/* sg block contains pure data */
				addr = miter.addr;
				length = miter.length;
			}

			/* last block, truncate length to data_size if needed */
			if (data_size && count > data_size) {
				length -= count - data_size;
				last = true;
			}

			ret = fpga_mgr_write(mgr, addr, length);
			if (ret || last)
				break;
		}

Thanks,
Yilun

>  		sg_miter_stop(&miter);
> @@ -262,10 +353,27 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
>  {
>  	int ret;
>  
> +	ret = fpga_mgr_parse_header_buf(mgr, info, buf, count);
> +	if (ret)
> +		return ret;
> +
> +	if (info->header_size + info->data_size > count) {
> +		dev_err(&mgr->dev, "Bitsream data outruns FPGA image\n");
> +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +		return -EINVAL;
> +	}
> +
>  	ret = fpga_mgr_write_init_buf(mgr, info, buf, count);
>  	if (ret)
>  		return ret;
>  
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
> @@ -424,6 +532,10 @@ static const char * const state_str[] = {
>  	[FPGA_MGR_STATE_FIRMWARE_REQ] =		"firmware request",
>  	[FPGA_MGR_STATE_FIRMWARE_REQ_ERR] =	"firmware request error",
>  
> +	/* Parse FPGA image header */
> +	[FPGA_MGR_STATE_PARSE_HEADER] =		"parse header",
> +	[FPGA_MGR_STATE_PARSE_HEADER_ERR] =	"parse header error",
> +
>  	/* Preparing FPGA to receive image */
>  	[FPGA_MGR_STATE_WRITE_INIT] =		"write init",
>  	[FPGA_MGR_STATE_WRITE_INIT_ERR] =	"write init error",
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 0f9468771bb9..cba8bb7827a5 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -22,6 +22,8 @@ struct sg_table;
>   * @FPGA_MGR_STATE_RESET: FPGA in reset state
>   * @FPGA_MGR_STATE_FIRMWARE_REQ: firmware request in progress
>   * @FPGA_MGR_STATE_FIRMWARE_REQ_ERR: firmware request failed
> + * @FPGA_MGR_STATE_PARSE_HEADER: parse FPGA image header
> + * @FPGA_MGR_STATE_PARSE_HEADER_ERR: Error during PARSE_HEADER stage
>   * @FPGA_MGR_STATE_WRITE_INIT: preparing FPGA for programming
>   * @FPGA_MGR_STATE_WRITE_INIT_ERR: Error during WRITE_INIT stage
>   * @FPGA_MGR_STATE_WRITE: writing image to FPGA
> @@ -42,6 +44,8 @@ enum fpga_mgr_states {
>  	FPGA_MGR_STATE_FIRMWARE_REQ_ERR,
>  
>  	/* write sequence: init, write, complete */
> +	FPGA_MGR_STATE_PARSE_HEADER,
> +	FPGA_MGR_STATE_PARSE_HEADER_ERR,
>  	FPGA_MGR_STATE_WRITE_INIT,
>  	FPGA_MGR_STATE_WRITE_INIT_ERR,
>  	FPGA_MGR_STATE_WRITE,
> @@ -85,6 +89,8 @@ enum fpga_mgr_states {
>   * @sgt: scatter/gather table containing FPGA image
>   * @buf: contiguous buffer containing FPGA image
>   * @count: size of buf
> + * @header_size: offset in image buffer where bitstream data starts
> + * @data_size: size of bitstream. If 0, (count - header_size) will be used.
>   * @region_id: id of target region
>   * @dev: device that owns this
>   * @overlay: Device Tree overlay
> @@ -98,6 +104,8 @@ struct fpga_image_info {
>  	struct sg_table *sgt;
>  	const char *buf;
>  	size_t count;
> +	size_t header_size;
> +	size_t data_size;
>  	int region_id;
>  	struct device *dev;
>  #ifdef CONFIG_OF
> @@ -137,9 +145,13 @@ struct fpga_manager_info {
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
> + *	required size to info->header_size and return -EAGAIN.
>   * @write_init: prepare the FPGA to receive configuration data
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
> @@ -155,6 +167,9 @@ struct fpga_manager_ops {
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
