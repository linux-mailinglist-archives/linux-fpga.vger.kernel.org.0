Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4398E434BBD
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 14:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhJTNCL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Oct 2021 09:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230201AbhJTNCL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 20 Oct 2021 09:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634734796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ct6AzxsLZvZzaTtpXmpX/t4/3JdzVca+UxLIgdtMXLM=;
        b=YDGsucE7hDkTMzO9tLKYdKAlUUIEKW8BafSLSG7L0BIGqyVXTfl2DH/FEFDf2jKqSZdO7D
        jDdKn1xMcXv91NSt+AO7nTBlRBwaF3TA7wZVWMQ0woJxzNqf8+SHUtatowpzZYFxgJ3Za0
        4cYBfl0zEBKnrVh1DXo2+i8trrOoR+k=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-E73cr986PlCP7b4AvjmrlQ-1; Wed, 20 Oct 2021 08:59:55 -0400
X-MC-Unique: E73cr986PlCP7b4AvjmrlQ-1
Received: by mail-pf1-f197.google.com with SMTP id d187-20020a6236c4000000b0044cf291bfebso1885178pfa.10
        for <linux-fpga@vger.kernel.org>; Wed, 20 Oct 2021 05:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ct6AzxsLZvZzaTtpXmpX/t4/3JdzVca+UxLIgdtMXLM=;
        b=ZQCB79x5fsJB8cCkN5HjLI0T2jO3EC5SUUY09hH/fdyk+IiDLoXiAGVZTXVRk1xHZe
         ks/0n9ahouOL/r4MQx55iw8bT3Myz+bcngpCAPwkz3ga0+bP96KaTUCiODj5aQltKmet
         dMAWcfcds/93jOpMjqlrfO5K+VbPGXK/06SKwsOP14s3yac28I5h/uRJ0/cVCH3vidgY
         mGHrEMJXK+x+efYcoFzc5LtKGFI+AX/9MNozix8eMVeQ6ZxYXK0OF+r8Ys/b+/wvNAI6
         9BIWYwcpX4MuLQnE7KmfE9qN8auwDaVYZSmZCQQM+1t00KIoO5ixtXUSU1i6bkTft33Y
         2a6w==
X-Gm-Message-State: AOAM531oOPPTT0iQOEQqQrSscVv9q/qfZ+RlBbKVoIsb+frETaPkOZsm
        RMeD39k/nmx8wkcYawJ+NYddoXwTXYv9fwZAf1CEoLZ0040JJALbjrAJnnGJxOkganO7cmOPozK
        wCWDGp7l85i/y2mgJLvOOcw==
X-Received: by 2002:a17:90b:3e85:: with SMTP id rj5mr7227111pjb.104.1634734794468;
        Wed, 20 Oct 2021 05:59:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqOZtXOyH6mb3QAlfIxTB2ohMzAcq6IrqWoqI+2PTacRqzqUfEWH0x962GShvqgmR6u6JaaA==
X-Received: by 2002:a17:90b:3e85:: with SMTP id rj5mr7227072pjb.104.1634734794020;
        Wed, 20 Oct 2021 05:59:54 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i13sm2257483pgf.77.2021.10.20.05.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:59:53 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] fpga: dfl: fme: Clear fme global errors at driver
 init
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20211019231545.47118-1-russell.h.weight@intel.com>
 <20211019231545.47118-3-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0b911b70-1cea-2d9e-1dfa-d1c743eae396@redhat.com>
Date:   Wed, 20 Oct 2021 05:59:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211019231545.47118-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/19/21 4:15 PM, Russ Weight wrote:
> When the fme-error driver initializes, log any pre-existing errors and
> clear them. To avoid code replication, common code is gathered into
> a common fme_err_clear() function and a structure (err_reg) is created
> to describe each of the error registers, the corresponding mask
> registers, and the default mask for each register.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>   drivers/fpga/dfl-fme-error.c | 128 +++++++++++++++++++++++------------
>   1 file changed, 84 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index 51c2892ec06d..44da7b30c469 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -39,6 +39,27 @@
>   
>   #define ERROR_MASK		GENMASK_ULL(63, 0)
>   
> +struct err_reg {
> +	char *name;
> +	u32 err_offset;
> +	u32 mask_offset;
> +	u32 mask_value;
> +};
> +
> +static struct err_reg pcie0_reg = {
> +	.name = "PCIE0",
> +	.err_offset = PCIE0_ERROR,
> +	.mask_offset = PCIE0_ERROR_MASK,
> +	.mask_value = 0ULL
> +};
> +
> +static struct err_reg pcie1_reg = {
> +	.name = "PCIE1",
> +	.err_offset = PCIE1_ERROR,
> +	.mask_offset = PCIE1_ERROR_MASK,
> +	.mask_value = 0ULL
> +};
> +
Can these be stored in an array ?
>   static ssize_t pcie0_errors_show(struct device *dev,
>   				 struct device_attribute *attr, char *buf)
>   {
> @@ -55,31 +76,48 @@ static ssize_t pcie0_errors_show(struct device *dev,
>   	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>   }
>   
> -static ssize_t pcie0_errors_store(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t count)
> +static int fme_err_clear(struct device *dev, struct err_reg *reg,
> +			 u64 err, bool clear_all)
>   {
>   	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>   	void __iomem *base;
>   	int ret = 0;
> -	u64 v, val;
> -
> -	if (kstrtou64(buf, 0, &val))
> -		return -EINVAL;
> +	u64 v;
>   
>   	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
>   
>   	mutex_lock(&pdata->lock);
> -	writeq(GENMASK_ULL(63, 0), base + PCIE0_ERROR_MASK);
> +	writeq(GENMASK_ULL(63, 0), base + reg->mask_offset);
>   
> -	v = readq(base + PCIE0_ERROR);
> -	if (val == v)
> -		writeq(v, base + PCIE0_ERROR);
> -	else
> +	v = readq(base + reg->err_offset);
> +	if (clear_all || err == v) {
> +		if (clear_all && v)
clear_all will over report.
> +			dev_warn(dev, "%s: %s Errors: 0x%llx\n",
> +				 __func__, reg->name, v);
> +
> +		writeq(v, base + reg->err_offset);
> +	} else {
>   		ret = -EINVAL;
> +	}
>   
> -	writeq(0ULL, base + PCIE0_ERROR_MASK);
> +	writeq(reg->mask_value, base + reg->mask_offset);
>   	mutex_unlock(&pdata->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t pcie0_errors_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	u64 val;
> +	int ret;
> +
> +	if (kstrtou64(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = fme_err_clear(dev, &pcie0_reg, val, false);
> +
>   	return ret ? ret : count;
>   }
>   static DEVICE_ATTR_RW(pcie0_errors);
> @@ -104,27 +142,14 @@ static ssize_t pcie1_errors_store(struct device *dev,
>   				  struct device_attribute *attr,
>   				  const char *buf, size_t count)
>   {
This looks like a copy of pcie0_errors_store can these functions be 
consolidated ?
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> -	void __iomem *base;
> -	int ret = 0;
> -	u64 v, val;
> +	u64 val;
> +	int ret;
>   
>   	if (kstrtou64(buf, 0, &val))
>   		return -EINVAL;
>   
> -	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
> +	ret = fme_err_clear(dev, &pcie1_reg, val, false);
>   
> -	mutex_lock(&pdata->lock);
> -	writeq(GENMASK_ULL(63, 0), base + PCIE1_ERROR_MASK);
> -
> -	v = readq(base + PCIE1_ERROR);
> -	if (val == v)
> -		writeq(v, base + PCIE1_ERROR);
> -	else
> -		ret = -EINVAL;
> -
> -	writeq(0ULL, base + PCIE1_ERROR_MASK);
> -	mutex_unlock(&pdata->lock);
>   	return ret ? ret : count;
>   }
>   static DEVICE_ATTR_RW(pcie1_errors);
> @@ -218,29 +243,26 @@ static ssize_t fme_errors_store(struct device *dev,
>   				struct device_attribute *attr,
>   				const char *buf, size_t count)
>   {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	static struct err_reg fme_reg = {
> +		.name = "FME",
> +		.err_offset = FME_ERROR,
> +		.mask_offset = FME_ERROR_MASK,
> +		.mask_value = 0ULL
> +	};
>   	void __iomem *base;
> -	u64 v, val;
> -	int ret = 0;
> +	u64 val;
> +	int ret;
>   
>   	if (kstrtou64(buf, 0, &val))
>   		return -EINVAL;
>   
> +	/* Workaround: disable MBP_ERROR if feature revision is 0 */
>   	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
> +	if (!dfl_feature_revision(base))
> +		fme_reg.mask_value = MBP_ERROR;
>   
> -	mutex_lock(&pdata->lock);
> -	writeq(GENMASK_ULL(63, 0), base + FME_ERROR_MASK);
> +	ret = fme_err_clear(dev, &fme_reg, val, false);
>   
> -	v = readq(base + FME_ERROR);
> -	if (val == v)
> -		writeq(v, base + FME_ERROR);
> -	else
> -		ret = -EINVAL;
> -
> -	/* Workaround: disable MBP_ERROR if feature revision is 0 */
> -	writeq(dfl_feature_revision(base) ? 0ULL : MBP_ERROR,
> -	       base + FME_ERROR_MASK);
> -	mutex_unlock(&pdata->lock);
>   	return ret ? ret : count;
>   }
>   static DEVICE_ATTR_RW(fme_errors);
> @@ -338,6 +360,24 @@ static void fme_err_mask(struct device *dev, bool mask)
>   static int fme_global_err_init(struct platform_device *pdev,
>   			       struct dfl_feature *feature)
>   {
> +	static struct err_reg fme_reg = {
> +		.name = "FME",
> +		.err_offset = FME_ERROR,
> +		.mask_offset = FME_ERROR_MASK,
> +		.mask_value = 0ULL
> +	};
> +	void __iomem *base;
> +
> +	/* Workaround: disable MBP_ERROR if feature revision is 0 */
> +	base = dfl_get_feature_ioaddr_by_id(&pdev->dev,
> +					    FME_FEATURE_ID_GLOBAL_ERR);
> +	if (!dfl_feature_revision(base))
> +		fme_reg.mask_value = MBP_ERROR;

A similar block above to set fme_reg.mask_value.

These should be consolidated.

> +
> +	(void)fme_err_clear(&pdev->dev, &pcie0_reg, 0ULL, true);

remove casting return to (void)

Tom

> +	(void)fme_err_clear(&pdev->dev, &pcie1_reg, 0ULL, true);
> +	(void)fme_err_clear(&pdev->dev, &fme_reg, 0ULL, true);
> +
>   	fme_err_mask(&pdev->dev, false);
>   
>   	return 0;

