Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FFB328D1A
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Mar 2021 20:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbhCATFg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Mar 2021 14:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240861AbhCATCm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Mar 2021 14:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614625273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qHdW/eIbIVKy8AipWSRDBE14YFP+txlHOwaoAbjXsdc=;
        b=gQ/BNPuqe9o1aZaLlhdBOzwb5302/otU5y6UBxZbhE7WTlDYpVPv5bmmElJoEuVli0rxFJ
        hWQkiqj6+ARWOQbwSdMsQL5edv+7UUMcUCxgX15+BVSE94xMPG5ZStX7QEuSXzyqvXEJzV
        f/eGZ0nfEdDe3omwgjuyfsMAaV7lBqs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-rlkzItD5O6CNE6ScWUTjwA-1; Mon, 01 Mar 2021 14:01:09 -0500
X-MC-Unique: rlkzItD5O6CNE6ScWUTjwA-1
Received: by mail-qv1-f71.google.com with SMTP id o14so2055773qvn.18
        for <linux-fpga@vger.kernel.org>; Mon, 01 Mar 2021 11:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qHdW/eIbIVKy8AipWSRDBE14YFP+txlHOwaoAbjXsdc=;
        b=tUgcgICxZyNc/PIT8d0BnJkRHyj7tPm0L3uM+5usoSqKY6sPWjcqjXIKqwStVuHlF4
         3igxLOrPFbnd5xcuzUWbiJrVRxRIRMSvjL6wu03AWgPf1qnOMDHHk7sHxviV0qQzyNLv
         1YgVhMAkCaQCheKz5L6kUcz1jQk0YoxD1+Y/+0wqhF/vBi/K45AV7RP03MeBrD0cpRMh
         LlWE9IYWNHIda0jgB/b0ORO0IvSRGaZDZlErY3xA5brj5HlY1+0NSWkZEs+tRVwQ9SBF
         z1BJpOBMZRZV4bpKJ63yNLMXVMuij45j6cVJyKPjVy3UL59T6mHLAHvUmeRCXNoTWvb2
         iP+g==
X-Gm-Message-State: AOAM53085rBspYA7PTwiPe4lXupxdHHFyltH0YZw/1mcFTSRptsgs6/H
        wK5DV11Mo/xEsLQbKWDWzBIuSs9kwyUKHr3+0CumkXdQQzpABL5bqLlFmmJCrsfRt/ShHr9YvGf
        p4SgVegHSbZeCFQENpYVmuw==
X-Received: by 2002:ac8:5c8f:: with SMTP id r15mr14503081qta.65.1614625268745;
        Mon, 01 Mar 2021 11:01:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYVKhGhgQLgVRmGb+q26ZqGt6+H78ZkrUqcAJYXd5Yn6H1UlLDZP5q+/49ejk09OMy+fVhJg==
X-Received: by 2002:ac8:5c8f:: with SMTP id r15mr14503036qta.65.1614625268385;
        Mon, 01 Mar 2021 11:01:08 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g89sm6560239qtd.75.2021.03.01.11.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 11:01:08 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 10/18] fpga: xrt: VSEC platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-11-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c574bbef-0165-22dd-f567-0be9f9819676@redhat.com>
Date:   Mon, 1 Mar 2021 11:01:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-11-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Add VSEC driver. VSEC is a hardware function discovered by walking
> PCI Express configure space. A platform device node will be created
> for it. VSEC provides board logic UUID and few offset of other hardware
> functions.
Is this vsec walking infra or is a general find a list of mmio regions that need to be mapped in and do the mapping in as a set of platform drivers ?
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/lib/xleaf/vsec.c | 359 ++++++++++++++++++++++++++++++
>  1 file changed, 359 insertions(+)
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>
> diff --git a/drivers/fpga/xrt/lib/xleaf/vsec.c b/drivers/fpga/xrt/lib/xleaf/vsec.c
> new file mode 100644
> index 000000000000..8e5cb22522ec
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/vsec.c
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA VSEC Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include "metadata.h"
> +#include "xleaf.h"
> +
> +#define XRT_VSEC "xrt_vsec"
> +
> +#define VSEC_TYPE_UUID		0x50
> +#define VSEC_TYPE_FLASH		0x51
> +#define VSEC_TYPE_PLATINFO	0x52
> +#define VSEC_TYPE_MAILBOX	0x53
> +#define VSEC_TYPE_END		0xff
Type of devices, this list can not grow much.
> +
> +#define VSEC_UUID_LEN		16
> +
> +struct xrt_vsec_header {
> +	u32		format;
> +	u32		length;
> +	u32		entry_sz;
> +	u32		rsvd;
> +} __packed;
> +
> +#define head_rd(g, r)			\
> +	ioread32((void *)(g)->base + offsetof(struct xrt_vsec_header, r))
> +
> +#define GET_BAR(entry)	(((entry)->bar_rev >> 4) & 0xf)
> +#define GET_BAR_OFF(_entry)				\
> +	({ typeof(_entry) entry = (_entry);		\
> +	 ((entry)->off_lo | ((u64)(entry)->off_hi << 16)); })

A 48 bit value stored in xrt_md_endpoint.bar_off (long)

bar_off should be u64 

> +#define GET_REV(entry)	((entry)->bar_rev & 0xf)
> +
I prefer functions over macros.
> +struct xrt_vsec_entry {
> +	u8		type;
> +	u8		bar_rev;
> +	u16		off_lo;
> +	u32		off_hi;
> +	u8		ver_type;
> +	u8		minor;
> +	u8		major;
> +	u8		rsvd0;
> +	u32		rsvd1;
> +} __packed;
> +
> +#define read_entry(g, i, e)					\
> +	do {							\
> +		u32 *p = (u32 *)((g)->base +			\
> +			sizeof(struct xrt_vsec_header) +	\
> +			(i) * sizeof(struct xrt_vsec_entry));	\
> +		u32 off;					\
> +		for (off = 0;					\
> +		    off < sizeof(struct xrt_vsec_entry) / 4;	\
> +		    off++)					\
> +			*((u32 *)(e) + off) = ioread32(p + off);\
> +	} while (0)
This could be a static inline func.
> +
> +struct vsec_device {
> +	u8		type;
> +	char		*ep_name;
> +	ulong		size;
> +	char		*regmap;
> +};
> +
> +static struct vsec_device vsec_devs[] = {
> +	{
> +		.type = VSEC_TYPE_UUID,
> +		.ep_name = XRT_MD_NODE_BLP_ROM,
> +		.size = VSEC_UUID_LEN,
> +		.regmap = "vsec-uuid",
> +	},
> +	{
> +		.type = VSEC_TYPE_FLASH,
> +		.ep_name = XRT_MD_NODE_FLASH_VSEC,
> +		.size = 4096,
> +		.regmap = "vsec-flash",
> +	},
> +	{
> +		.type = VSEC_TYPE_PLATINFO,
> +		.ep_name = XRT_MD_NODE_PLAT_INFO,
> +		.size = 4,
> +		.regmap = "vsec-platinfo",
> +	},
> +	{
> +		.type = VSEC_TYPE_MAILBOX,
> +		.ep_name = XRT_MD_NODE_MAILBOX_VSEC,
> +		.size = 48,
> +		.regmap = "vsec-mbx",
> +	},
This is a static list, how would a new type be added to this ?
> +};
> +
> +struct xrt_vsec {
> +	struct platform_device	*pdev;
> +	void			*base;
> +	ulong			length;
> +
> +	char			*metadata;
> +	char			uuid[VSEC_UUID_LEN];
> +};
> +
> +static char *type2epname(u32 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
> +		if (vsec_devs[i].type == type)
> +			return (vsec_devs[i].ep_name);
> +	}
> +
> +	return NULL;
> +}
> +
> +static ulong type2size(u32 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
> +		if (vsec_devs[i].type == type)
> +			return (vsec_devs[i].size);
> +	}
> +
> +	return 0;
> +}
> +
> +static char *type2regmap(u32 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
> +		if (vsec_devs[i].type == type)
> +			return (vsec_devs[i].regmap);
> +	}
> +
> +	return NULL;
> +}
> +
> +static int xrt_vsec_add_node(struct xrt_vsec *vsec,
> +			     void *md_blob, struct xrt_vsec_entry *p_entry)
> +{
> +	struct xrt_md_endpoint ep;
> +	char regmap_ver[64];
> +	int ret;
> +
> +	if (!type2epname(p_entry->type))
> +		return -EINVAL;
> +
> +	/*
> +	 * VSEC may have more than 1 mailbox instance for the card
> +	 * which has more than 1 physical function.
> +	 * This is not supported for now. Assuming only one mailbox
> +	 */

are multiple uuid types allowed ?

this says assume 1, but logic will recreate 1+

can you check if a mbx ep exists before creating ?

> +
> +	snprintf(regmap_ver, sizeof(regmap_ver) - 1, "%d-%d.%d.%d",
> +		 p_entry->ver_type, p_entry->major, p_entry->minor,
> +		 GET_REV(p_entry));
> +	ep.ep_name = type2epname(p_entry->type);
> +	ep.bar = GET_BAR(p_entry);
> +	ep.bar_off = GET_BAR_OFF(p_entry);
here is the bar_off type overlow
> +	ep.size = type2size(p_entry->type);
> +	ep.regmap = type2regmap(p_entry->type);
> +	ep.regmap_ver = regmap_ver;
> +	ret = xrt_md_add_endpoint(DEV(vsec->pdev), vsec->metadata, &ep);
> +	if (ret) {
> +		xrt_err(vsec->pdev, "add ep failed, ret %d", ret);
> +		goto failed;
> +	}
> +
> +failed:
> +	return ret;
> +}
> +
> +static int xrt_vsec_create_metadata(struct xrt_vsec *vsec)
> +{
> +	struct xrt_vsec_entry entry;
> +	int i, ret;
> +
> +	ret = xrt_md_create(&vsec->pdev->dev, &vsec->metadata);
> +	if (ret) {
> +		xrt_err(vsec->pdev, "create metadata failed");
> +		return ret;
> +	}
> +
> +	for (i = 0; i * sizeof(entry) < vsec->length -
> +	    sizeof(struct xrt_vsec_header); i++) {
> +		read_entry(vsec, i, &entry);
> +		xrt_vsec_add_node(vsec, vsec->metadata, &entry);
This can fail.
> +	}
> +
> +	return 0;
> +}
> +
> +static int xrt_vsec_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Does not handle any event. */
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		xrt_err(pdev, "should never been called");
> +		break;
> +	}
This function looks like a noop.  Is anything going to be added to this later ?
> +
> +	return ret;
> +}
> +
> +static int xrt_vsec_mapio(struct xrt_vsec *vsec)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(vsec->pdev);
> +	const u32 *bar;
> +	const u64 *bar_off;
> +	struct resource *res = NULL;
> +	ulong addr;
> +	int ret;
> +
> +	if (!pdata || xrt_md_size(DEV(vsec->pdev), pdata->xsp_dtb) == XRT_MD_INVALID_LENGTH) {
> +		xrt_err(vsec->pdev, "empty metadata");
> +		return -EINVAL;
> +	}
> +
> +	ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
> +			      NULL, XRT_MD_PROP_BAR_IDX, (const void **)&bar, NULL);
> +	if (ret) {
> +		xrt_err(vsec->pdev, "failed to get bar idx, ret %d", ret);
> +		return -EINVAL;
> +	}
> +
> +	ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
> +			      NULL, XRT_MD_PROP_OFFSET, (const void **)&bar_off, NULL);
> +	if (ret) {
> +		xrt_err(vsec->pdev, "failed to get bar off, ret %d", ret);
> +		return -EINVAL;
> +	}
> +
> +	xrt_info(vsec->pdev, "Map vsec at bar %d, offset 0x%llx",
> +		 be32_to_cpu(*bar), be64_to_cpu(*bar_off));
> +
> +	xleaf_get_barres(vsec->pdev, &res, be32_to_cpu(*bar));
> +	if (!res) {
> +		xrt_err(vsec->pdev, "failed to get bar addr");
> +		return -EINVAL;
> +	}
> +
> +	addr = res->start + (ulong)be64_to_cpu(*bar_off);
review this type, addr is ulong and bar_off is not.
> +
> +	vsec->base = ioremap(addr, sizeof(struct xrt_vsec_header));
> +	if (!vsec->base) {
> +		xrt_err(vsec->pdev, "Map header failed");
> +		return -EIO;
> +	}

why the double call on ioremap ?

just do the last one.

> +
> +	vsec->length = head_rd(vsec, length);
> +	iounmap(vsec->base);
> +	vsec->base = ioremap(addr, vsec->length);
> +	if (!vsec->base) {
> +		xrt_err(vsec->pdev, "map failed");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xrt_vsec_remove(struct platform_device *pdev)
> +{
> +	struct xrt_vsec	*vsec;
> +
> +	vsec = platform_get_drvdata(pdev);
> +
> +	if (vsec->base) {
> +		iounmap(vsec->base);
> +		vsec->base = NULL;
> +	}
> +
> +	vfree(vsec->metadata);
> +
> +	return 0;
> +}
> +
> +static int xrt_vsec_probe(struct platform_device *pdev)
> +{
> +	struct xrt_vsec	*vsec;
> +	int			ret = 0;
> +
> +	vsec = devm_kzalloc(&pdev->dev, sizeof(*vsec), GFP_KERNEL);
> +	if (!vsec)
> +		return -ENOMEM;
> +
> +	vsec->pdev = pdev;
> +	platform_set_drvdata(pdev, vsec);
> +
> +	ret = xrt_vsec_mapio(vsec);
> +	if (ret)
> +		goto failed;
> +
> +	ret = xrt_vsec_create_metadata(vsec);
> +	if (ret) {
> +		xrt_err(pdev, "create metadata failed, ret %d", ret);
> +		goto failed;
> +	}
> +	ret = xleaf_create_group(pdev, vsec->metadata);
> +	if (ret < 0)
> +		xrt_err(pdev, "create group failed, ret %d", ret);
> +	else
> +		ret = 0;

why is it just

if (ret)

  fail ?

Tom

> +
> +failed:
> +	if (ret)
> +		xrt_vsec_remove(pdev);
> +
> +	return ret;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_vsec_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names []){
> +			{ .ep_name = XRT_MD_NODE_VSEC },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_vsec_data = {
> +	.xsd_dev_ops = {
> +		.xsd_ioctl = xrt_vsec_ioctl,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_vsec_table[] = {
> +	{ XRT_VSEC, (kernel_ulong_t)&xrt_vsec_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_vsec_driver = {
> +	.driver = {
> +		.name = XRT_VSEC,
> +	},
> +	.probe = xrt_vsec_probe,
> +	.remove = xrt_vsec_remove,
> +	.id_table = xrt_vsec_table,
> +};
> +
> +void vsec_leaf_init_fini(bool init)
> +{
> +	if (init)
> +		xleaf_register_driver(XRT_SUBDEV_VSEC, &xrt_vsec_driver, xrt_vsec_endpoints);
> +	else
> +		xleaf_unregister_driver(XRT_SUBDEV_VSEC);
> +}

