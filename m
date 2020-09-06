Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E1225EF38
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Sep 2020 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgIFRGU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 6 Sep 2020 13:06:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725841AbgIFRGT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 6 Sep 2020 13:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599411977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5pi6kmTJtxrXnrQ1o1+D6zOwv348s2nRgWp9tupDkI=;
        b=hmD9TuT33iGm7kTPDz4sMo9Xo9SomaGHbidX0sTpv6VK1GAWZMNU6+LcCllgiy7FiY5h0q
        Im3XwnlvKZKPP7xTssXJIXZ3Z871rM0wE0AMLeYl6rIPgCZ5tudahCZ5pJqJExY5y6bjwX
        ruonXCghIttxMHSNl/zl6us4Cv6uY6M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-xHfRgCTKNI6RcNtIiHDMMA-1; Sun, 06 Sep 2020 13:06:14 -0400
X-MC-Unique: xHfRgCTKNI6RcNtIiHDMMA-1
Received: by mail-qk1-f198.google.com with SMTP id v16so6439325qka.18
        for <linux-fpga@vger.kernel.org>; Sun, 06 Sep 2020 10:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T5pi6kmTJtxrXnrQ1o1+D6zOwv348s2nRgWp9tupDkI=;
        b=kFS2F1vS8CjjmbTzLyiimU9SbruqTQRSURY6xR0lam6aea0K+xN+BgQFt4E0xUQVUi
         /qX+YayQIr7A4nWGkdGEfxcTHHNsZNXH3lw/sGNB2ZUeq2fKU8DJReXY11eiPisxnRVj
         tmwyMm3szaGhfqMFMdKjW6qhcFRv3IWPGIMIu/IBVSDHTR/0ofGAcyMv8EMwLbzpmjx1
         gaO44QEKno06DQG5JwmZ8r4X+bYzyvCrLgdEcnxHt8sYRx16f1iuS80/9RmKnhVhY0gI
         lwWGyyH9BQ7DRGUNO/Dgb2hbCQse9hqt3RIp8p2PVk7+7N/TQJXHOUrZGaknIU+9BHX2
         eydQ==
X-Gm-Message-State: AOAM531flS2UR7QM44DBinkzqmPeO7R+ektCApFmGzQvr4JwmzdwAaQS
        2Ct6BYeSNbrV9zYqWF4dNruiIvz/jCFLkCq+YiOy0tMaiD5rme1vX9KVrnVzvMKFuuDfS8LAgSF
        zTHcNXZNCFXNqEIFNCBnHBg==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr17095450qti.81.1599411973916;
        Sun, 06 Sep 2020 10:06:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo748fLBdA5RyKGQNX2aeM+TJI+XXQQaO6Zso/HBz7x5qVE4vXAIL+HZQE97QTNo1oBVMwNQ==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr17095428qti.81.1599411973625;
        Sun, 06 Sep 2020 10:06:13 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g19sm2702267qka.84.2020.09.06.10.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 10:06:12 -0700 (PDT)
Subject: Re: [PATCH v1 11/12] fpga: expose hardware error info in sysfs
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-12-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <35c1452d-9a26-802a-a340-41f1482ef975@redhat.com>
Date:   Sun, 6 Sep 2020 10:06:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-12-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:53 PM, Russ Weight wrote:
> Extend the Intel Security Manager class driver to include
> an optional update/hw_errinfo sysfs node that can be used
> to retrieve 64 bits of device specific error information
> following a secure update failure.
>
> The underlying driver must provide a get_hw_errinfo() callback
> function to enable this feature. This data is treated as
> opaque by the class driver. It is left to user-space software
> or support personnel to interpret this data.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 14 +++++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 38 +++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            |  5 +++
>  3 files changed, 57 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index 762a7dee9453..20bde1abb5e4 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -135,3 +135,17 @@ Description:	Read-only. Returns a string describing the failure
>  		idle state. If this file is read while a secure
>  		update is in progress, then the read will fail with
>  		EBUSY.
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/hw_errinfo
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns a 64 bit error value providing
> +		hardware specific information that may be useful in
> +		debugging errors that occur during FPGA image updates.
> +		This file is only visible if the underlying device
> +		supports it. The hw_errinfo value is only accessible
> +		when the secure update engine is in the idle state.
> +		If this file is read while a secure update is in
> +		progress, then the read will fail with EBUSY.
> +		Format: "0x%llx".
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index afd97c135ebe..6944396eff80 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -152,10 +152,17 @@ static void set_error(struct ifpga_sec_mgr *imgr, enum ifpga_sec_err err_code)
>  	imgr->err_code = err_code;
>  }
>  
> +static void set_hw_errinfo(struct ifpga_sec_mgr *imgr)
> +{
> +	if (imgr->iops->get_hw_errinfo)
> +		imgr->hw_errinfo = imgr->iops->get_hw_errinfo(imgr);
> +}
> +
>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>  				enum ifpga_sec_err err_code)
>  {
>  	set_error(imgr, err_code);
> +	set_hw_errinfo(imgr);
>  	imgr->iops->cancel(imgr);
>  }
>  
> @@ -348,6 +355,23 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(error);
>  
> +static ssize_t
> +hw_errinfo_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +	int ret;
> +
> +	mutex_lock(&imgr->lock);
> +	if (imgr->progress != IFPGA_SEC_PROG_IDLE)
> +		ret = -EBUSY;
> +	else
> +		ret = sprintf(buf, "0x%llx\n", imgr->hw_errinfo);
> +	mutex_unlock(&imgr->lock);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(hw_errinfo);
> +
>  static ssize_t remaining_size_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -382,6 +406,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  		imgr->filename[strlen(imgr->filename) - 1] = '\0';
>  
>  	imgr->err_code = IFPGA_SEC_ERR_NONE;
> +	imgr->hw_errinfo = 0;
>  	imgr->request_cancel = false;
>  	imgr->progress = IFPGA_SEC_PROG_READ_FILE;
>  	reinit_completion(&imgr->update_done);
> @@ -416,18 +441,31 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(cancel);
>  
> +static umode_t
> +sec_mgr_update_visible(struct kobject *kobj, struct attribute *attr, int n)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(kobj_to_dev(kobj));
> +
> +	if (attr == &dev_attr_hw_errinfo.attr && !imgr->iops->get_hw_errinfo)
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
>  static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
>  	&dev_attr_cancel.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_error.attr,
>  	&dev_attr_remaining_size.attr,
> +	&dev_attr_hw_errinfo.attr,
>  	NULL,
>  };
>  
>  static struct attribute_group sec_mgr_update_attr_group = {
>  	.name = "update",
>  	.attrs = sec_mgr_update_attrs,
> +	.is_visible = sec_mgr_update_visible,
>  };
>  
>  static ssize_t name_show(struct device *dev,
> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
> index f51ed663a723..3be8d8da078a 100644
> --- a/include/linux/fpga/ifpga-sec-mgr.h
> +++ b/include/linux/fpga/ifpga-sec-mgr.h
> @@ -135,6 +135,9 @@ enum ifpga_sec_err {
>   *			    function and is called at the completion
>   *			    of the update, whether success or failure,
>   *			    if the prepare function succeeded.
> + * @get_hw_errinfo:	    Optional: Return u64 hw specific error info.
> + *			    The software err_code may used to determine
> + *			    whether the hw error info is applicable.
>   */
>  struct ifpga_sec_mgr_ops {
>  	sysfs_cnt_hndlr_t user_flash_count;
> @@ -158,6 +161,7 @@ struct ifpga_sec_mgr_ops {
>  	enum ifpga_sec_err (*poll_complete)(struct ifpga_sec_mgr *imgr);
>  	void (*cleanup)(struct ifpga_sec_mgr *imgr);
>  	enum ifpga_sec_err (*cancel)(struct ifpga_sec_mgr *imgr);
> +	u64 (*get_hw_errinfo)(struct ifpga_sec_mgr *imgr);
>  };
>  
>  /* Update progress codes */
> @@ -183,6 +187,7 @@ struct ifpga_sec_mgr {
>  	enum ifpga_sec_prog progress;
>  	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
>  	enum ifpga_sec_err err_code;	/* security manager error code */
> +	u64 hw_errinfo;			/* 64 bits of HW specific error info */
>  	bool request_cancel;
>  	bool driver_unload;
>  	void *priv;

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

