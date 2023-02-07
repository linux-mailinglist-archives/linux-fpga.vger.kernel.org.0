Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9068E029
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Feb 2023 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjBGSfI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Feb 2023 13:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjBGSet (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Feb 2023 13:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB3ACE
        for <linux-fpga@vger.kernel.org>; Tue,  7 Feb 2023 10:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675794825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r4dk1pt3rVf0DezC5j1bcpiMVKfa9+mkcXLjjOT80ow=;
        b=KL5JNPx0MTPkN4zTX7RZiYgWVdUnGHIbOA/VMc8K1lXyu092Vf5Su/6ZMAwzvHEWoHzK0j
        NRMB/5Trwj8uI6xktKm0+3xMwRMpCgYAeFPVhvASbYY+qf1hn+d41vG52Sq+KTZiOpzCH4
        l8gt6YeYyhOxWXlRoUfOZlH+9OVtAzw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-kKe3Blw8O6uEDYm4CgWDAw-1; Tue, 07 Feb 2023 13:33:44 -0500
X-MC-Unique: kKe3Blw8O6uEDYm4CgWDAw-1
Received: by mail-qt1-f199.google.com with SMTP id s4-20020ac85284000000b003b849aa2cd6so9042183qtn.15
        for <linux-fpga@vger.kernel.org>; Tue, 07 Feb 2023 10:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4dk1pt3rVf0DezC5j1bcpiMVKfa9+mkcXLjjOT80ow=;
        b=wASQ7lcO7OlZ7QqGQAxv5O1hi8+Va//NOfxTADke8TxJ20BV07wm8zi3lX6picog36
         DDAZAd/I2juIDlM/jKUnkN1niSalD2tXuOKLk9L+/+5Qj6ZepZTi/fWimCy/qphxB8Cx
         OFJLsR6Yrm8SUc3RGxMjDuxs4LZHL6OgMjrE17bod2hOOIb/1bNGoXvGdyHzEJn/QE1L
         uAki3duMVVJJk9Hywds55eH5jPRNb7H5QnuwXyBqtyAcaHA+rapepI8p1P5PIffu56FK
         xrinCyU5MdmNl8IpJXASGptiA4mLIRC9RCM+NWk20G8kZJfw6j8n9CN1DfX5BD07B+xQ
         sXTw==
X-Gm-Message-State: AO0yUKXq9i5yJcCc40Z0ox+kOdP3BC4kfes0CV0fOPrQmok0ylpFSw3a
        KEZTIJJzwotCGf+oiG8+cz743++n8lO9ckV/9QAkA07LKQ8eBOziigxrGmgP5y2UObcmyB4BobW
        b/SDw5iPBBX5Out0fIMN+
X-Received: by 2002:a05:6214:509b:b0:537:712d:92ab with SMTP id kk27-20020a056214509b00b00537712d92abmr6399130qvb.48.1675794823632;
        Tue, 07 Feb 2023 10:33:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+Y1+uLa0gX4N5ByiIJXh2T4klu3VYUsxZN7CNhdsXq48O8YiL5d3dZ7Lhbg7pho6f/aL4ObQ==
X-Received: by 2002:a05:6214:509b:b0:537:712d:92ab with SMTP id kk27-20020a056214509b00b00537712d92abmr6399099qvb.48.1675794823353;
        Tue, 07 Feb 2023 10:33:43 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id d188-20020a3768c5000000b006fa7b5ea2d1sm9956048qkc.125.2023.02.07.10.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:33:42 -0800 (PST)
Message-ID: <8d34bc43-deb4-4166-83ad-34561ee5ac33@redhat.com>
Date:   Tue, 7 Feb 2023 19:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] fpga: mgr: Update the state to provide the exact error
 code
Content-Language: en-US
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     Nava kishore Manne <nava.kishore.manne@amd.com>, mdf@kernel.org,
        hao.wu@intel.com, trix@redhat.com, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207095915.169146-1-nava.kishore.manne@amd.com>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20230207095915.169146-1-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2023-02-07 10:59, Nava kishore Manne wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> Up on fpga configuration failure, the existing sysfs state interface
> is just providing the generic error message rather than providing the
> exact error code. This patch extends sysfs state interface to provide
> the exact error received from the lower layer along with the existing
> generic error message.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/fpga-mgr.c       | 20 +++++++++++++++++++-
>  include/linux/fpga/fpga-mgr.h |  2 ++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 8efa67620e21..b2d74705a5a2 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -61,12 +61,14 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
>  {
>  	int ret = 0;
>  
> +	mgr->err = 0;
>  	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
>  	if (mgr->mops->write_complete)
>  		ret = mgr->mops->write_complete(mgr, info);
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
>  		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
> +		mgr->err = ret;
>  		return ret;
>  	}
>  	mgr->state = FPGA_MGR_STATE_OPERATING;
> @@ -154,6 +156,7 @@ static int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,
>  {
>  	int ret;
>  
> +	mgr->err = 0;
>  	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
>  	ret = fpga_mgr_parse_header(mgr, info, buf, count);
>  
> @@ -165,6 +168,7 @@ static int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
>  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +		mgr->err = ret;
>  	}
>  
>  	return ret;
> @@ -185,6 +189,7 @@ static int fpga_mgr_parse_header_sg_first(struct fpga_manager *mgr,
>  	int ret;
>  
>  	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> +	mgr->err = 0;
>  
>  	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
>  	if (sg_miter_next(&miter) &&
> @@ -197,6 +202,7 @@ static int fpga_mgr_parse_header_sg_first(struct fpga_manager *mgr,
>  	if (ret && ret != -EAGAIN) {
>  		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
>  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +		mgr->err = ret;
>  	}
>  
>  	return ret;
> @@ -249,6 +255,7 @@ static void *fpga_mgr_parse_header_sg(struct fpga_manager *mgr,
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
>  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +		mgr->err = ret;
>  		kfree(buf);
>  		buf = ERR_PTR(ret);
>  	}
> @@ -272,6 +279,7 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  	size_t header_size = info->header_size;
>  	int ret;
>  
> +	mgr->err = 0;
>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
>  
>  	if (header_size > count)
> @@ -284,6 +292,7 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
>  		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
> +		mgr->err = ret;
>  		return ret;
>  	}
>  
> @@ -370,6 +379,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  
>  	/* Write the FPGA image to the FPGA. */
>  	mgr->state = FPGA_MGR_STATE_WRITE;
> +	mgr->err = 0;
>  	if (mgr->mops->write_sg) {
>  		ret = fpga_mgr_write_sg(mgr, sgt);
>  	} else {
> @@ -405,6 +415,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
>  		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
> +		mgr->err = ret;
>  		return ret;
>  	}
>  
> @@ -437,10 +448,12 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
>  	 * Write the FPGA image to the FPGA.
>  	 */
>  	mgr->state = FPGA_MGR_STATE_WRITE;
> +	mgr->err = 0;
>  	ret = fpga_mgr_write(mgr, buf, count);
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
>  		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
> +		mgr->err = ret;
>  		return ret;
>  	}
>  
> @@ -544,10 +557,11 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
>  	dev_info(dev, "writing %s to %s\n", image_name, mgr->name);
>  
>  	mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ;
> -
> +	mgr->err = 0;
>  	ret = request_firmware(&fw, image_name, dev);
>  	if (ret) {
>  		mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ_ERR;
> +		mgr->err = ret;
>  		dev_err(dev, "Error requesting firmware %s\n", image_name);
>  		return ret;
>  	}
> @@ -626,6 +640,10 @@ static ssize_t state_show(struct device *dev,
>  {
>  	struct fpga_manager *mgr = to_fpga_manager(dev);
>  
> +	if (mgr->err)
> +		return sprintf(buf, "%s: 0x%x\n",
> +			       state_str[mgr->state], mgr->err);
> +
>  	return sprintf(buf, "%s\n", state_str[mgr->state]);


If one of the fpga manager ops fails, the low-level error code is already
returned to the caller. Wouldn't it be better to rely on this instead of
printing the low-level error code in a sysfs attribute and sending it to
the userspace?


>  }
>  
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 54f63459efd6..be3a426ef903 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -202,6 +202,7 @@ struct fpga_manager_ops {
>   * @compat_id: FPGA manager id for compatibility check.
>   * @mops: pointer to struct of fpga manager ops
>   * @priv: low level driver private date
> + * @err: low level driver error code
>   */
>  struct fpga_manager {
>  	const char *name;
> @@ -211,6 +212,7 @@ struct fpga_manager {
>  	struct fpga_compat_id *compat_id;
>  	const struct fpga_manager_ops *mops;
>  	void *priv;
> +	int err;
>  };
>  
>  #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)


Thanks,
Marco

