Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174C0372BBA
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhEDOMX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 10:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231425AbhEDOMX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 May 2021 10:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620137488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+t0xOrtGLTv8ZdJeDhoC1So3Unr3E5PmFkWvCjuPoM=;
        b=h7H6uty75OUStXDpK8LTSXljjSK3GaoCYVzIGlpVrxMicSxVb/l4Lo7tQ0pvM0m6lF4qMn
        0z5xZ5k8TcE0b9og1KuC76frqd9k07Bh5y/GcvL3MD7rKkqXeeVI0chF2ReFlQIVAAi+Z0
        D5kR4BzWzK+GQ/QDQQAB8WdA2niTVY0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-aeqAI0BOPnOczcg_TKPS6g-1; Tue, 04 May 2021 10:11:26 -0400
X-MC-Unique: aeqAI0BOPnOczcg_TKPS6g-1
Received: by mail-qt1-f198.google.com with SMTP id g21-20020ac858150000b02901ba6163708bso3626706qtg.5
        for <linux-fpga@vger.kernel.org>; Tue, 04 May 2021 07:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0+t0xOrtGLTv8ZdJeDhoC1So3Unr3E5PmFkWvCjuPoM=;
        b=N8Egztx+8sdGuN7jQ/oayPAF7FkfeRq3neZUp8avdPJbaqDWY+JgzgcVHHdtvnnfeU
         HO0sRyuWh0v3au3ygx6wSGTz6TAQo0uOj6JtfnLPvwqP3fR2yiqgQIfIV4/DbAk7Z87o
         kKctK95n8VX+UIq6hOXpzSSNXgML0Q2Sb3PtdfNJ9lu+0uxyQOVEvsiC9h8YotzYp+l+
         txfhe6vRbjhng3F7oZKS1Z/zPb39Gk4D5dewXUon+h9IjGkMh0mpkLBliL8zBCdIoPX/
         1XL7h9OzDtNiUxWpU+1Uchzz2ZNpYr0FCxCq75Sjdzli8fNyX+8/OqsaAhS+NHMODDSJ
         Gbag==
X-Gm-Message-State: AOAM531RbtzDJCeiHE91do+GwptLkFKYlK6fP92wAjkF3Fqkj+kKVfjP
        l/f9tJmaDL5AvMY6EuTVnnqJAuaW+QepH1gxmsY6mWUMnag2lt55EICMNcYpFuvzVOyesl4/2WQ
        AY4d27lff+ozF9i3KRTOf7g==
X-Received: by 2002:a0c:a404:: with SMTP id w4mr26017819qvw.45.1620137486211;
        Tue, 04 May 2021 07:11:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw41P/PLWZsCRJf70qrTmI90b0S4l7u+kMDbmNzEmyaCW7kLNtYLwJgJESo2S4Oq1C+dkUdpA==
X-Received: by 2002:a0c:a404:: with SMTP id w4mr26017800qvw.45.1620137486002;
        Tue, 04 May 2021 07:11:26 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q67sm11290821qkb.89.2021.05.04.07.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:11:25 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 18/20] fpga: xrt: DDR calibration driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-19-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <43575631-b2fd-a0fb-6147-6c3984e93a72@redhat.com>
Date:   Tue, 4 May 2021 07:11:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-19-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> Add DDR calibration driver. DDR calibration is a hardware function
> discovered by walking firmware metadata. A xrt device node will
> be created for it. Hardware provides DDR calibration status through
> this function.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>

v4 was ok, please add my Reviewed-by line

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
>   .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +++
>   drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 ++++++++++++++++++
>   2 files changed, 238 insertions(+)
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
> index 000000000000..36a0937c9195
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
> @@ -0,0 +1,210 @@
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
> +XRT_DEFINE_REGMAP_CONFIG(calib_regmap_config);
> +
> +struct calib_cache {
> +	struct list_head	link;
> +	const char		*ep_name;
> +	char			*data;
> +	u32			data_size;
> +};
> +
> +struct calib {
> +	struct xrt_device	*xdev;
> +	struct regmap		*regmap;
> +	struct mutex		lock; /* calibration dev lock */
> +	struct list_head	cache_list;
> +	u32			cache_num;
> +	enum xrt_calib_results	result;
> +};
> +
> +static void __calib_cache_clean_nolock(struct calib *calib)
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
> +	u32 status;
> +	int ret;
> +
> +	while (times != 0) {
> +		ret = regmap_read(calib->regmap, XRT_CALIB_STATUS_REG, &status);
> +		if (ret) {
> +			xrt_err(calib->xdev, "failed to read status reg %d", ret);
> +			return ret;
> +		}
> +
> +		if (status & BIT(0))
> +			break;
> +		msleep(XRT_CALIB_READ_INTERVAL);
> +		times--;
> +	}
> +
> +	if (!times) {
> +		xrt_err(calib->xdev,
> +			"MIG calibration timeout after bitstream download");
> +		return -ETIMEDOUT;
> +	}
> +
> +	xrt_info(calib->xdev, "took %dms", (XRT_CALIB_READ_RETRIES - times) *
> +		 XRT_CALIB_READ_INTERVAL);
> +	return 0;
> +}
> +
> +static void xrt_calib_event_cb(struct xrt_device *xdev, void *arg)
> +{
> +	struct calib *calib = xrt_get_drvdata(xdev);
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
> +		xrt_dbg(xdev, "ignored event %d", e);
> +		break;
> +	}
> +}
> +
> +static void xrt_calib_remove(struct xrt_device *xdev)
> +{
> +	struct calib *calib = xrt_get_drvdata(xdev);
> +
> +	calib_cache_clean(calib);
> +}
> +
> +static int xrt_calib_probe(struct xrt_device *xdev)
> +{
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	struct calib *calib;
> +	int err = 0;
> +
> +	calib = devm_kzalloc(&xdev->dev, sizeof(*calib), GFP_KERNEL);
> +	if (!calib)
> +		return -ENOMEM;
> +
> +	calib->xdev = xdev;
> +	xrt_set_drvdata(xdev, calib);
> +
> +	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		err = -EINVAL;
> +		goto failed;
> +	}
> +
> +	base = devm_ioremap_resource(&xdev->dev, res);
> +	if (IS_ERR(base)) {
> +		err = PTR_ERR(base);
> +		goto failed;
> +	}
> +
> +	calib->regmap = devm_regmap_init_mmio(&xdev->dev, base, &calib_regmap_config);
> +	if (IS_ERR(calib->regmap)) {
> +		xrt_err(xdev, "Map iomem failed");
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
> +xrt_calib_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
> +{
> +	struct calib *calib = xrt_get_drvdata(xdev);
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_calib_event_cb(xdev, arg);
> +		break;
> +	case XRT_CALIB_RESULT: {
> +		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
> +		*r = calib->result;
> +		break;
> +	}
> +	default:
> +		xrt_err(xdev, "unsupported cmd %d", cmd);
> +		ret = -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static struct xrt_dev_endpoints xrt_calib_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_dev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_DDR_CALIB },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_driver xrt_calib_driver = {
> +	.driver = {
> +		.name = XRT_CALIB,
> +	},
> +	.subdev_id = XRT_SUBDEV_CALIB,
> +	.endpoints = xrt_calib_endpoints,
> +	.probe = xrt_calib_probe,
> +	.remove = xrt_calib_remove,
> +	.leaf_call = xrt_calib_leaf_call,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(calib);

