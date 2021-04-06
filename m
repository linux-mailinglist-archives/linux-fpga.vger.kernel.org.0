Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E88355CFF
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhDFUho (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 16:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245476AbhDFUhn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Apr 2021 16:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617741454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHiiDAoRDKlSpF5W2fiqmIZUSD2zT3WhpbrUrOmekT8=;
        b=hip1QzYAFvzeK6yy4OpikIXyWvyJ9NU91Fj1ttO7D664C0hFnoQTVOo+lH8B2uhkc8/JbX
        U+iJUCz66M8rssqK0iPGH8QDR9KY/rtNthfd0YqDHUgi4eZMRC0e07lNI8b28+RfVQkgMi
        mKLvow0UJZDV+j8+aUyWtx69s7NmREs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-1nKF71jhNiuqpxZzcC0F-g-1; Tue, 06 Apr 2021 16:37:33 -0400
X-MC-Unique: 1nKF71jhNiuqpxZzcC0F-g-1
Received: by mail-qk1-f197.google.com with SMTP id c1so13421515qke.8
        for <linux-fpga@vger.kernel.org>; Tue, 06 Apr 2021 13:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SHiiDAoRDKlSpF5W2fiqmIZUSD2zT3WhpbrUrOmekT8=;
        b=YxERG1dsGlKLZa56UlYT0hz8oGLGP5BvzV/ugrNCUdEqDAKvO40BU1hvkjpZJlGDhd
         C2gpMnAFzpiaW7TPJE0bWCvRDsl26mYMAm/SEXVG/clSyEZ4vMit8zKXkYHsGyHXDHTD
         XYno4VIU+ohGZuF/E5uGemWfywbYx5JCNQ9xdD2vu/Qv/q//Q7cWfOWKkTXw68FPxYGc
         qlSEkl7Rz743IlG6pUHlwMJlHmYFc95gDzCj05aleLEW3VJPU8ssNE5P0MxTW2jDbfv2
         dtgUv5FZC0FQYLvLlFUy9iY3EtZpOVZmy1l+jLU3d6A8fx9U/KH2LsruivxhYmYAQL1F
         +8uQ==
X-Gm-Message-State: AOAM530w+KTkvMbTw/SfXQfVEUc5nUpG9OtNjOPEoLJZZnxL77vV4a3g
        tQ7jWGErVa++IA/NTgCVNpLPOrO0MCGq2dZccB5zvrFOWIknZGqISxDrR2krffFJBBEOIMAqx30
        7iQ1omdsMVpce0AJk/Ul2GA==
X-Received: by 2002:a37:886:: with SMTP id 128mr32868771qki.430.1617741452686;
        Tue, 06 Apr 2021 13:37:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLZhl4CZ/pjvsSTD4KFAyWmQlrZ0/IFXc0KJjTWwwbI8yN5HySIRFXvGe6WMCCxmPU46vnmQ==
X-Received: by 2002:a37:886:: with SMTP id 128mr32868749qki.430.1617741452457;
        Tue, 06 Apr 2021 13:37:32 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c17sm14751116qtd.71.2021.04.06.13.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 13:37:31 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 18/20] fpga: xrt: DDR calibration platform
 driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-19-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e529c014-f2d5-a0d2-dba9-4325af41c425@redhat.com>
Date:   Tue, 6 Apr 2021 13:37:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-19-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Add DDR calibration driver. DDR calibration is a hardware function
> discovered by walking firmware metadata. A platform device node will
> be created for it. Hardware provides DDR calibration status through
> this function.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +++
>   drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 226 ++++++++++++++++++
ok
>   2 files changed, 254 insertions(+)
>   create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/ddr_calibration.h b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
> new file mode 100644
> index 000000000000..878740c26ca2
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_DDR_CALIBRATION_H_
> +#define _XRT_DDR_CALIBRATION_H_
> +
> +#include "xleaf.h"
> +#include <linux/xrt/xclbin.h>
> +
> +/*
> + * Memory calibration driver leaf calls.
> + */
> +enum xrt_calib_results {
> +	XRT_CALIB_UNKNOWN = 0,
ok
> +	XRT_CALIB_SUCCEEDED,
> +	XRT_CALIB_FAILED,
> +};
> +
> +enum xrt_calib_leaf_cmd {
> +	XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +};
> +
> +#endif	/* _XRT_DDR_CALIBRATION_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
> new file mode 100644
> index 000000000000..5a9fa82946cb
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA memory calibration driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * memory calibration
> + *
> + * Authors:
> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
> + */
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include "xclbin-helper.h"
> +#include "metadata.h"
> +#include "xleaf/ddr_calibration.h"
> +
> +#define XRT_CALIB	"xrt_calib"
> +
> +#define XRT_CALIB_STATUS_REG		0
> +#define XRT_CALIB_READ_RETRIES		20
> +#define XRT_CALIB_READ_INTERVAL		500 /* ms */
> +
> +static const struct regmap_config calib_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x1000,
ok
> +};
> +
> +struct calib_cache {
> +	struct list_head	link;
> +	const char		*ep_name;
> +	char			*data;
> +	u32			data_size;
> +};
> +
> +struct calib {
> +	struct platform_device	*pdev;
> +	struct regmap		*regmap;
> +	struct mutex		lock; /* calibration dev lock */
> +	struct list_head	cache_list;
> +	u32			cache_num;
> +	enum xrt_calib_results	result;
> +};
> +
> +static void __calib_cache_clean_nolock(struct calib *calib)
ok
> +{
> +	struct calib_cache *cache, *temp;
> +
> +	list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
> +		vfree(cache->data);
> +		list_del(&cache->link);
> +		vfree(cache);
> +	}
> +	calib->cache_num = 0;
> +}
> +
> +static void calib_cache_clean(struct calib *calib)
> +{
> +	mutex_lock(&calib->lock);
> +	__calib_cache_clean_nolock(calib);
> +	mutex_unlock(&calib->lock);
> +}
> +
> +static int calib_calibration(struct calib *calib)
> +{
> +	u32 times = XRT_CALIB_READ_RETRIES;
ok
> +	u32 status;
> +	int ret;
> +
> +	while (times != 0) {
> +		ret = regmap_read(calib->regmap, XRT_CALIB_STATUS_REG, &status);
> +		if (ret) {
> +			xrt_err(calib->pdev, "failed to read status reg %d", ret);
> +			return ret;
> +		}
> +
> +		if (status & BIT(0))
> +			break;
> +		msleep(XRT_CALIB_READ_INTERVAL);

ok

Reviewed-by: Tom Rix <trix@redhat.com>

> +		times--;
> +	}
> +
> +	if (!times) {
> +		xrt_err(calib->pdev,
> +			"MIG calibration timeout after bitstream download");
> +		return -ETIMEDOUT;
> +	}
> +
> +	xrt_info(calib->pdev, "took %dms", (XRT_CALIB_READ_RETRIES - times) *
> +		 XRT_CALIB_READ_INTERVAL);
> +	return 0;
> +}
> +
> +static void xrt_calib_event_cb(struct platform_device *pdev, void *arg)
> +{
> +	struct calib *calib = platform_get_drvdata(pdev);
> +	struct xrt_event *evt = (struct xrt_event *)arg;
> +	enum xrt_events e = evt->xe_evt;
> +	enum xrt_subdev_id id;
> +	int ret;
> +
> +	id = evt->xe_subdev.xevt_subdev_id;
> +
> +	switch (e) {
> +	case XRT_EVENT_POST_CREATION:
> +		if (id == XRT_SUBDEV_UCS) {
> +			ret = calib_calibration(calib);
> +			if (ret)
> +				calib->result = XRT_CALIB_FAILED;
> +			else
> +				calib->result = XRT_CALIB_SUCCEEDED;
> +		}
> +		break;
> +	default:
> +		xrt_dbg(pdev, "ignored event %d", e);
> +		break;
> +	}
> +}
> +
> +static int xrt_calib_remove(struct platform_device *pdev)
> +{
> +	struct calib *calib = platform_get_drvdata(pdev);
> +
> +	calib_cache_clean(calib);
> +
> +	return 0;
> +}
> +
> +static int xrt_calib_probe(struct platform_device *pdev)
> +{
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	struct calib *calib;
> +	int err = 0;
> +
> +	calib = devm_kzalloc(&pdev->dev, sizeof(*calib), GFP_KERNEL);
> +	if (!calib)
> +		return -ENOMEM;
> +
> +	calib->pdev = pdev;
> +	platform_set_drvdata(pdev, calib);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		err = -EINVAL;
> +		goto failed;
> +	}
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base)) {
> +		err = PTR_ERR(base);
> +		goto failed;
> +	}
> +
> +	calib->regmap = devm_regmap_init_mmio(&pdev->dev, base, &calib_regmap_config);
> +	if (IS_ERR(calib->regmap)) {
> +		xrt_err(pdev, "Map iomem failed");
> +		err = PTR_ERR(calib->regmap);
> +		goto failed;
> +	}
> +
> +	mutex_init(&calib->lock);
> +	INIT_LIST_HEAD(&calib->cache_list);
> +
> +	return 0;
> +
> +failed:
> +	return err;
> +}
> +
> +static int
> +xrt_calib_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	struct calib *calib = platform_get_drvdata(pdev);
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_calib_event_cb(pdev, arg);
> +		break;
> +	case XRT_CALIB_RESULT: {
> +		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
> +		*r = calib->result;
> +		break;
> +	}
> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		ret = -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_calib_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_DDR_CALIB },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_calib_data = {
> +	.xsd_dev_ops = {
> +		.xsd_leaf_call = xrt_calib_leaf_call,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_calib_table[] = {
> +	{ XRT_CALIB, (kernel_ulong_t)&xrt_calib_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_calib_driver = {
> +	.driver = {
> +		.name = XRT_CALIB,
> +	},
> +	.probe = xrt_calib_probe,
> +	.remove = xrt_calib_remove,
> +	.id_table = xrt_calib_table,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_CALIB, calib);

