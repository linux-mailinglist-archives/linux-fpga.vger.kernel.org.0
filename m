Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60875352B57
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Apr 2021 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhDBOMW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Apr 2021 10:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234628AbhDBOMV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Apr 2021 10:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617372740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVxqEz+W1E++fBKyXT9Ua+krxoktOGMhTV6mQ8ytN1g=;
        b=CRgr5zWuEC+JvbFeTOkf8JzHe3P3sobxOH3991LQCjx3LpJ6fQFhvtajRnDRKuk1FfmQUF
        6NTYk/3MYMDy4Njl85vvTOhKWAipb7pqF5XPzABki6CIyW5uhvdzdqhhkERgK5pMX6zFFf
        E+Fs2tiizKZFRAomQOqk4HTA/UKZL2o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-7fUyi_OBOAOK3PVUPTu9HA-1; Fri, 02 Apr 2021 10:12:18 -0400
X-MC-Unique: 7fUyi_OBOAOK3PVUPTu9HA-1
Received: by mail-qk1-f200.google.com with SMTP id b136so5818267qkc.20
        for <linux-fpga@vger.kernel.org>; Fri, 02 Apr 2021 07:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HVxqEz+W1E++fBKyXT9Ua+krxoktOGMhTV6mQ8ytN1g=;
        b=tSOUqvoAVoPG3PtcYQ9uxLhy0aWm07UOtdHiK1crzRCG2wHonC+AZD/k+WeXOTNenP
         IchlM9gYBe1zdST27gqFKqDHz6QmQmFNr9YPBb0NwVDfqul+bAnycZcAEVEfoDgZxCOf
         pzAK+9/sgYcE/nirGWuybyhQ+FRgykfMxcMz/KAqCV3VFt44o9toZ6M117Ag6Nzp/XqA
         Py4RPVXvJRjd0pJ3FcPfh+neZ86XzT8vx2Od4ifnPoUUjrhjOMkGneDvhzXylHXF7kNr
         hNcINbfgAuG7nW02qpSQCVSjiQsbPMOIIw/rsaTGfD8AvNaMGkxr+4WpgjB2+8znG43y
         4A0Q==
X-Gm-Message-State: AOAM533fFk78AnSpizYGJl6tnPY20U7y/dOcmkXXvKt/SE47HFSWXjcb
        T4544lBuXgT6NIKVMzC41UM2i1+XxeqOCFCbtBycBEDPOMYE/w5v5PkIwuJ/1OY8X7UKdfqPirY
        LGF9C4VV/rR/PouLLUFdqiA==
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr12829239qvb.37.1617372737839;
        Fri, 02 Apr 2021 07:12:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb2Ww2ssHbsNsyvT360AYKv9bFG/WTGG8rtM6U+J0UxqAr3r4KkP1XmyiMIFTvQ2vrq+ojPw==
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr12829208qvb.37.1617372737537;
        Fri, 02 Apr 2021 07:12:17 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 18sm7524852qkr.77.2021.04.02.07.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 07:12:17 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 12/20] fpga: xrt: VSEC platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-13-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d26476fc-e559-72eb-0e6f-decb06ca7227@redhat.com>
Date:   Fri, 2 Apr 2021 07:12:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-13-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

local use of 'regmap' conflicts with global meaning.

reword local regmap to something else.

On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Add VSEC driver. VSEC is a hardware function discovered by walking
> PCI Express configure space. A platform device node will be created
> for it. VSEC provides board logic UUID and few offset of other hardware
> functions.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/xrt/lib/xleaf/vsec.c | 388 ++++++++++++++++++++++++++++++
>  1 file changed, 388 insertions(+)
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>
> diff --git a/drivers/fpga/xrt/lib/xleaf/vsec.c b/drivers/fpga/xrt/lib/xleaf/vsec.c
> new file mode 100644
> index 000000000000..8595d23f5710
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/vsec.c
> @@ -0,0 +1,388 @@
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
> +#include <linux/regmap.h>
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
> +
> +#define VSEC_UUID_LEN		16
> +
> +#define VSEC_REG_FORMAT		0x0
> +#define VSEC_REG_LENGTH		0x4
> +#define VSEC_REG_ENTRY		0x8
> +
> +struct xrt_vsec_header {
> +	u32		format;
> +	u32		length;
> +	u32		entry_sz;
> +	u32		rsvd;
> +} __packed;
> +
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
> +struct vsec_device {
> +	u8		type;
> +	char		*ep_name;
> +	ulong		size;
> +	char		*regmap;

This element should be 'char *name;' as regmap is a different thing.

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
> +};
> +
> +static const struct regmap_config vsec_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x1000,
At least 0x1000 could be #define, maybe all.
> +};
> +
> +struct xrt_vsec {
> +	struct platform_device	*pdev;
> +	struct regmap		*regmap;
> +	u32			length;
> +
> +	char			*metadata;
> +	char			uuid[VSEC_UUID_LEN];
> +	int			group;
> +};
> +
> +static inline int vsec_read_entry(struct xrt_vsec *vsec, u32 index, struct xrt_vsec_entry *entry)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(vsec->regmap, sizeof(struct xrt_vsec_header) +
> +			       index * sizeof(struct xrt_vsec_entry), entry,
> +			       sizeof(struct xrt_vsec_entry) /
> +			       vsec_regmap_config.reg_stride);
> +
> +	return ret;
> +}
> +
> +static inline u32 vsec_get_bar(struct xrt_vsec_entry *entry)
> +{
> +	return ((entry)->bar_rev >> 4) & 0xf;

The extra () were needed when this was a macro, they aren't now.

remove here and the next 2 functions.

> +}
> +
> +static inline u64 vsec_get_bar_off(struct xrt_vsec_entry *entry)
> +{
> +	return (entry)->off_lo | ((u64)(entry)->off_hi << 16);
> +}
> +
> +static inline u32 vsec_get_rev(struct xrt_vsec_entry *entry)
> +{
> +	return (entry)->bar_rev & 0xf;
> +}
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
> +
> +	snprintf(regmap_ver, sizeof(regmap_ver) - 1, "%d-%d.%d.%d",
> +		 p_entry->ver_type, p_entry->major, p_entry->minor,
> +		 vsec_get_rev(p_entry));
> +	ep.ep_name = type2epname(p_entry->type);
> +	ep.bar = vsec_get_bar(p_entry);
> +	ep.bar_off = vsec_get_bar_off(p_entry);
ok
> +	ep.size = type2size(p_entry->type);
> +	ep.regmap = type2regmap(p_entry->type);
> +	ep.regmap_ver = regmap_ver;
> +	ret = xrt_md_add_endpoint(DEV(vsec->pdev), vsec->metadata, &ep);
> +	if (ret)
> +		xrt_err(vsec->pdev, "add ep failed, ret %d", ret);
> +
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
> +		ret = vsec_read_entry(vsec, i, &entry);
> +		if (ret) {
> +			xrt_err(vsec->pdev, "failed read entry %d, ret %d", i, ret);
> +			goto fail;
> +		}
> +
> +		if (entry.type == VSEC_TYPE_END)
> +			break;
> +		ret = xrt_vsec_add_node(vsec, vsec->metadata, &entry);
> +		if (ret)
> +			goto fail;
ok
> +	}
> +
> +	return 0;
> +
> +fail:
> +	vfree(vsec->metadata);
> +	vsec->metadata = NULL;
> +	return ret;
> +}
> +
> +static int xrt_vsec_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
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
> +
> +	return ret;
> +}
> +
> +static int xrt_vsec_mapio(struct xrt_vsec *vsec)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(vsec->pdev);
> +	struct resource *res = NULL;
> +	void __iomem *base = NULL;
> +	const u64 *bar_off;
> +	const u32 *bar;
> +	u64 addr;
ok
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
> +	addr = res->start + be64_to_cpu(*bar_off);
> +
> +	base = devm_ioremap(&vsec->pdev->dev, addr, vsec_regmap_config.max_register);
> +	if (!base) {
> +		xrt_err(vsec->pdev, "Map failed");
> +		return -EIO;
> +	}
> +
> +	vsec->regmap = devm_regmap_init_mmio(&vsec->pdev->dev, base, &vsec_regmap_config);
> +	if (IS_ERR(vsec->regmap)) {
> +		xrt_err(vsec->pdev, "regmap %pR failed", res);
> +		return PTR_ERR(vsec->regmap);
> +	}
> +
> +	ret = regmap_read(vsec->regmap, VSEC_REG_LENGTH, &vsec->length);
> +	if (ret) {
> +		xrt_err(vsec->pdev, "failed to read length %d", ret);
> +		return ret;
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
> +	if (vsec->group >= 0)
> +		xleaf_destroy_group(pdev, vsec->group);
> +	vfree(vsec->metadata);
> +
> +	return 0;
> +}
> +
> +static int xrt_vsec_probe(struct platform_device *pdev)
> +{
> +	struct xrt_vsec	*vsec;
> +	int ret = 0;
> +
> +	vsec = devm_kzalloc(&pdev->dev, sizeof(*vsec), GFP_KERNEL);
> +	if (!vsec)
> +		return -ENOMEM;
> +
> +	vsec->pdev = pdev;
> +	vsec->group = -1;
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
> +	vsec->group = xleaf_create_group(pdev, vsec->metadata);
> +	if (ret < 0) {

this is a bug, ret is not set by xleaf_create_group

Tom

> +		xrt_err(pdev, "create group failed, ret %d", vsec->group);
> +		ret = vsec->group;
> +		goto failed;
> +	}
> +
> +	return 0;
> +
> +failed:
> +	xrt_vsec_remove(pdev);
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
> +		.xsd_leaf_call = xrt_vsec_leaf_call,
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
> +XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_VSEC, vsec);

