Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48485576C9
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Jun 2022 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiFWJgr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Jun 2022 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiFWJgq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 23 Jun 2022 05:36:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3D496AB;
        Thu, 23 Jun 2022 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655976998; x=1687512998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P37z1bB3s2DTRPoVx9+b1nlx2keXAzc0YgK3zLRTrg0=;
  b=L5vRobIE24VDuzQxe9SRy1Ot6S2FpWxYelyqsElohnvQs3fKNGVGHBet
   sfS6X4WLCssExV00a8cJ72DIqzLQuWkku3c9Nmey8VVsrT2tXsIogro48
   b207+ZQeqRuwmR270tUNfDslAyE+vp7BMKe2XgJsRp16PV+7wY/gEd8VM
   9E4kCFu1EpuxguLIATLUpn0DIaRbAgrKqouk3qSG2RS+Xndn1hgbOctQT
   6yvzDjCv1JoREXYdzVlMLvg9cYWCkjtymxRMv8Zg7B5mR/tBq3Xj6EgKR
   3bWjFpnIgy4i9EVo9oOYnu73KuyTA6/HlpMKgrKXh8Dk0Cdy9hv+39mek
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263707280"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="263707280"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 02:36:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="834560462"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 02:36:32 -0700
Date:   Thu, 23 Jun 2022 17:28:22 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, corbet@lwn.net,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v21 1/5] fpga: fpga-mgr: support bitstream offset in
 image buffer
Message-ID: <20220623092822.GA1752270@yilunxu-OptiPlex-7050>
References: <20220621153847.103052-1-i.bornyakov@metrotek.ru>
 <20220621153847.103052-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621153847.103052-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 21, 2022 at 06:38:43PM +0300, Ivan Bornyakov wrote:
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
> Add header_size and data_size to the fpga_image_info struct, add
> skip_header to the fpga_manager_ops struct and adjust fpga_mgr_write()
> callers with respect to them.
> 
>   * info->header_size indicates part at the beginning of image buffer
>     that contains some meta info. It is optional and can be 0,
>     initialized with mops->initial_header_size.
> 
>   * mops->skip_header tells fpga-mgr core whether write should start
>     from the beginning of image buffer or at the offset of header_size.
> 
>   * info->data_size is the size of bitstream data that is meant to be
>     written to the device. It is also optional and can be 0, which
>     means bitstream data is up to the end of image buffer.
> 
> Also add parse_header() callback to fpga_manager_ops, which purpose is
> to set info->header_size and info->data_size. At least
> initial_header_size bytes of image buffer will be passed into
> parse_header() first time. If it is not enough, parse_header() should
> set desired size into info->header_size and return -EAGAIN, then it will
> be called again with greater part of image buffer on the input.
> 
> Suggested-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/fpga-mgr.c       | 225 ++++++++++++++++++++++++++++++----
>  include/linux/fpga/fpga-mgr.h |  24 +++-
>  2 files changed, 222 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 08dc85fcd511..d97df0bdc72b 100644
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
> @@ -136,24 +145,141 @@ void fpga_image_info_free(struct fpga_image_info *info)
>  EXPORT_SYMBOL_GPL(fpga_image_info_free);
>  
>  /*
> - * Call the low level driver's write_init function.  This will do the
> + * Call the low level driver's parse_header function with entire FPGA image
> + * buffer on the input. This will set info->header_size and info->data_size.
> + */
> +static int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,
> +					struct fpga_image_info *info,
> +					const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> +	ret = fpga_mgr_parse_header(mgr, info, buf, count);
> +
> +	if (info->header_size + info->data_size > count) {
> +		dev_err(&mgr->dev, "Bitsream data outruns FPGA image\n");
> +		ret = -EINVAL;
> +	}
> +
> +	if (ret) {
> +		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
> +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Call the low level driver's parse_header function with first fragment of
> + * scattered FPGA image on the input. If header fits first fragment,
> + * parse_header will set info->header_size and info->data_size. If it is not,
> + * parse_header will set desired size to info->header_size and -EAGAIN will be
> + * returned.
> + */
> +static int fpga_mgr_parse_header_sg_first(struct fpga_manager *mgr,
> +					  struct fpga_image_info *info,
> +					  struct sg_table *sgt)
> +{
> +	struct sg_mapping_iter miter;
> +	int ret;
> +
> +	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> +
> +	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> +	if (sg_miter_next(&miter) &&
> +	    miter.length >= info->header_size)
> +		ret = fpga_mgr_parse_header(mgr, info, miter.addr, miter.length);
> +	else
> +		ret = -EAGAIN;
> +	sg_miter_stop(&miter);
> +
> +	if (ret && ret != -EAGAIN) {
> +		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
> +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Copy scattered FPGA image fragments to temporary buffer and call the
> + * low level driver's parse_header function. This should be called after
> + * fpga_mgr_parse_header_sg_first() returned -EAGAIN. In case of success,
> + * pointer to the newly allocated image header copy will be returned and
> + * its size will be set into *ret_size. Returned buffer needs to be freed.
> + */
> +static void *fpga_mgr_parse_header_sg(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info,
> +				      struct sg_table *sgt, size_t *ret_size)
> +{
> +	size_t len, new_header_size, header_size = 0;
> +	char *new_buf, *buf = NULL;
> +	int ret;
> +
> +	do {
> +		new_header_size = info->header_size;
> +		if (new_header_size <= header_size) {
> +			dev_err(&mgr->dev, "Requested invalid header size\n");
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		new_buf = krealloc(buf, new_header_size, GFP_KERNEL);
> +		if (!new_buf) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		buf = new_buf;
> +
> +		len = sg_pcopy_to_buffer(sgt->sgl, sgt->nents,
> +					 buf + header_size,
> +					 new_header_size - header_size,
> +					 header_size);
> +		if (len != new_header_size - header_size) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		header_size = new_header_size;
> +		ret = fpga_mgr_parse_header(mgr, info, buf, header_size);
> +	} while (ret == -EAGAIN);
> +
> +	if (ret) {
> +		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
> +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +		kfree(buf);
> +		buf = ERR_PTR(ret);
> +	}
> +
> +	*ret_size = header_size;
> +
> +	return buf;
> +}
> +
> +/*
> + * Call the low level driver's write_init function. This will do the
>   * device-specific things to get the FPGA into the state where it is ready to
> - * receive an FPGA image. The low level driver only gets to see the first
> - * initial_header_size bytes in the buffer.
> + * receive an FPGA image. The low level driver gets to see at least first
> + * info->header_size bytes in the buffer. If info->header_size is 0,
> + * write_init will not get any bytes of image buffer.
>   */
>  static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  				   struct fpga_image_info *info,
>  				   const char *buf, size_t count)
>  {
> +	size_t header_size = info->header_size;
>  	int ret;
>  
>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> -	if (!mgr->mops->initial_header_size) {
> +
> +	if (header_size > count)
> +		ret = -EINVAL;
> +	else if (!header_size)
>  		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
> -	} else {
> -		count = min(mgr->mops->initial_header_size, count);
> +	else
>  		ret = fpga_mgr_write_init(mgr, info, buf, count);
> -	}
>  
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
> @@ -164,39 +290,50 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  	return 0;
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
>  	size_t len;
>  	char *buf;
>  	int ret;
>  
> -	if (!mgr->mops->initial_header_size)
> +	/* Short path. Low level driver don't care about image header. */
> +	if (!mgr->mops->initial_header_size && !mgr->mops->parse_header)
>  		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
>  
>  	/*
>  	 * First try to use miter to map the first fragment to access the
>  	 * header, this is the typical path.
>  	 */
> -	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> -	if (sg_miter_next(&miter) &&
> -	    miter.length >= mgr->mops->initial_header_size) {
> -		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
> -					      miter.length);
> +	ret = fpga_mgr_parse_header_sg_first(mgr, info, sgt);
> +	/* If 0, header fits first fragment, call write_init on it */
> +	if (!ret) {
> +		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> +		if (sg_miter_next(&miter)) {
> +			ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
> +						      miter.length);
> +			sg_miter_stop(&miter);
> +			return ret;
> +		}
>  		sg_miter_stop(&miter);
> +	/*
> +	 * If -EAGAIN, more sg buffer is needed,
> +	 * otherwise an error has occurred.
> +	 */
> +	} else if (ret != -EAGAIN) {
>  		return ret;
>  	}
> -	sg_miter_stop(&miter);
>  
> -	/* Otherwise copy the fragments into temporary memory. */
> -	buf = kmalloc(mgr->mops->initial_header_size, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +	/*
> +	 * Copy the fragments into temporary memory.
> +	 * Copying is done inside fpga_mgr_parse_header_sg().
> +	 */
> +	buf = fpga_mgr_parse_header_sg(mgr, info, sgt, &len);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
>  
> -	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
> -				mgr->mops->initial_header_size);
>  	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
>  
>  	kfree(buf);
> @@ -227,7 +364,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  {
>  	int ret;
>  
> -	ret = fpga_mgr_write_init_sg(mgr, info, sgt);
> +	ret = fpga_mgr_prepare_sg(mgr, info, sgt);
>  	if (ret)
>  		return ret;
>  
> @@ -236,17 +373,37 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  	if (mgr->mops->write_sg) {
>  		ret = fpga_mgr_write_sg(mgr, sgt);
>  	} else {
> +		size_t length, data_size = info->data_size;
>  		struct sg_mapping_iter miter;
> +		ssize_t count = 0;
>  
>  		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> +
> +		if (mgr->mops->skip_header &&
> +		    !sg_miter_skip(&miter, info->header_size)) {
> +			ret = -EINVAL;
> +			sg_miter_stop(&miter);

Seems sg_miter_stop is not need if sg_miter_skip reaches end, is it?

Thanks,
Yilun

> +			goto out;
> +		}
> +
>  		while (sg_miter_next(&miter)) {
> -			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
> +			if (data_size)
> +				length = min(miter.length, data_size - count);
> +			else
> +				length = miter.length;
> +
> +			ret = fpga_mgr_write(mgr, miter.addr, length);
>  			if (ret)
>  				break;
> +
> +			count += length;
> +			if (data_size && count >= data_size)
> +				break;
>  		}
>  		sg_miter_stop(&miter);
>  	}
>  
> +out:
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
>  		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
> @@ -262,10 +419,22 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
>  {
>  	int ret;
>  
> +	ret = fpga_mgr_parse_header_mapped(mgr, info, buf, count);
> +	if (ret)
> +		return ret;
> +
>  	ret = fpga_mgr_write_init_buf(mgr, info, buf, count);
>  	if (ret)
>  		return ret;
>  
> +	if (mgr->mops->skip_header) {
> +		buf += info->header_size;
> +		count -= info->header_size;
> +	}
> +
> +	if (info->data_size)
> +		count = info->data_size;
> +
>  	/*
>  	 * Write the FPGA image to the FPGA.
>  	 */
> @@ -404,6 +573,8 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
>   */
>  int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
>  {
> +	info->header_size = mgr->mops->initial_header_size;
> +
>  	if (info->sgt)
>  		return fpga_mgr_buf_load_sg(mgr, info, info->sgt);
>  	if (info->buf && info->count)
> @@ -424,6 +595,10 @@ static const char * const state_str[] = {
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
> index 0f9468771bb9..54f63459efd6 100644
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
> @@ -41,7 +43,9 @@ enum fpga_mgr_states {
>  	FPGA_MGR_STATE_FIRMWARE_REQ,
>  	FPGA_MGR_STATE_FIRMWARE_REQ_ERR,
>  
> -	/* write sequence: init, write, complete */
> +	/* write sequence: parse header, init, write, complete */
> +	FPGA_MGR_STATE_PARSE_HEADER,
> +	FPGA_MGR_STATE_PARSE_HEADER_ERR,
>  	FPGA_MGR_STATE_WRITE_INIT,
>  	FPGA_MGR_STATE_WRITE_INIT_ERR,
>  	FPGA_MGR_STATE_WRITE,
> @@ -85,6 +89,9 @@ enum fpga_mgr_states {
>   * @sgt: scatter/gather table containing FPGA image
>   * @buf: contiguous buffer containing FPGA image
>   * @count: size of buf
> + * @header_size: size of image header.
> + * @data_size: size of image data to be sent to the device. If not specified,
> + *	whole image will be used. Header may be skipped in either case.
>   * @region_id: id of target region
>   * @dev: device that owns this
>   * @overlay: Device Tree overlay
> @@ -98,6 +105,8 @@ struct fpga_image_info {
>  	struct sg_table *sgt;
>  	const char *buf;
>  	size_t count;
> +	size_t header_size;
> +	size_t data_size;
>  	int region_id;
>  	struct device *dev;
>  #ifdef CONFIG_OF
> @@ -137,9 +146,16 @@ struct fpga_manager_info {
>  
>  /**
>   * struct fpga_manager_ops - ops for low level fpga manager drivers
> - * @initial_header_size: Maximum number of bytes that should be passed into write_init
> + * @initial_header_size: minimum number of bytes that should be passed into
> + *	parse_header and write_init.
> + * @skip_header: bool flag to tell fpga-mgr core whether it should skip
> + *	info->header_size part at the beginning of the image when invoking
> + *	write callback.
>   * @state: returns an enum value of the FPGA's state
>   * @status: returns status of the FPGA, including reconfiguration error code
> + * @parse_header: parse FPGA image header to set info->header_size and
> + *	info->data_size. In case the input buffer is not large enough, set
> + *	required size to info->header_size and return -EAGAIN.
>   * @write_init: prepare the FPGA to receive configuration data
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
> @@ -153,8 +169,12 @@ struct fpga_manager_info {
>   */
>  struct fpga_manager_ops {
>  	size_t initial_header_size;
> +	bool skip_header;
>  	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
>  	u64 (*status)(struct fpga_manager *mgr);
> +	int (*parse_header)(struct fpga_manager *mgr,
> +			    struct fpga_image_info *info,
> +			    const char *buf, size_t count);
>  	int (*write_init)(struct fpga_manager *mgr,
>  			  struct fpga_image_info *info,
>  			  const char *buf, size_t count);
> -- 
> 2.25.1
> 
