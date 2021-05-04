Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6C372B86
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEDOBR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 10:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231216AbhEDOBR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 May 2021 10:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620136821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydvzYWdRvl+KlpTeAMA2MJoz0W6fUH9mRq4lk2Tbotw=;
        b=WkX3EfABnmrUpzGMJhjy6kWG9ID/HWTDttse3cCjnnMPf6x3EQ76ZJALw5d4zP1Ptd33+8
        SzBsn+gXZJ5Rf6O/psdCtuWAKXyaqLysnw2DkvAcwJGEv6U8iWq3SHVtT+3EQxtY5GI55+
        jZCXotP3Fcsn4ZjJ0nvtZ5AKeuGedek=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-0G9rYx4oP8iCVc539CY3xw-1; Tue, 04 May 2021 10:00:20 -0400
X-MC-Unique: 0G9rYx4oP8iCVc539CY3xw-1
Received: by mail-qk1-f200.google.com with SMTP id b19-20020a05620a0893b02902e956b29f5dso7543313qka.16
        for <linux-fpga@vger.kernel.org>; Tue, 04 May 2021 07:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ydvzYWdRvl+KlpTeAMA2MJoz0W6fUH9mRq4lk2Tbotw=;
        b=aSy4Yw1Yj9V+tGmp1YYOZdCCxeA8LIPlcUmirRLkZBZStYMdBoehMP/K4BKQ0H3yKe
         gJ2cWugl6EiVwDUcwOywEqc4OYX3G12ekfiO1gV+m2W1yNnnRmF+X75ONG3KqGJbCqjf
         GBve/vSQsFeatJ/y9l+pCjwnxzxXpRCb4OXmwYlurEb66fBXTVnWdSwi2LYboxXf1R3W
         Uy+ZZa0znSdG5WcYRs02a0oEjN2wyKFOeL8GOwESF13IKBLoWtP7/bBJcMdV54OMGSuG
         VB67K3pLGluT4+cDSq4Dqri4SkipxUhlf6+CQjurwAx1pSNHqhocnTWcg7jzwtFl7LWS
         IAEg==
X-Gm-Message-State: AOAM530VxsBBm79dFXwQGO8JOLTsuI2d3s4jg6CeAB6siiXIJPivaLVc
        DyI/QAgL1G+SZGuOQhoUgXWvqJjMFokRklm74QA+W/P0RMe/woVKXjrESgbm+GZLxJAb7AqdAXw
        LxGHYI8AzVljqumbTlnzBQQ==
X-Received: by 2002:a37:9ec4:: with SMTP id h187mr8478315qke.200.1620136819924;
        Tue, 04 May 2021 07:00:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdtE8dg15Rd3Tzag7HHoTs6488DrHU5nxqvlIbjx2kZ2m/5GdZA9kKA5dqyti30dGNtn5uJA==
X-Received: by 2002:a37:9ec4:: with SMTP id h187mr8478289qke.200.1620136819709;
        Tue, 04 May 2021 07:00:19 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x18sm1049067qkx.118.2021.05.04.07.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:00:19 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 12/20] fpga: xrt: VSEC driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-13-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <af80c7b4-f866-6964-e0a0-5b1941668881@redhat.com>
Date:   Tue, 4 May 2021 07:00:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-13-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> Add VSEC driver. VSEC is a hardware function discovered by walking
> PCI Express configure space. A xrt device node will be created for it.
> VSEC provides board logic UUID and few offset of other hardware functions.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/fpga/xrt/lib/xleaf/vsec.c | 372 ++++++++++++++++++++++++++++++
>   1 file changed, 372 insertions(+)
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>
> diff --git a/drivers/fpga/xrt/lib/xleaf/vsec.c b/drivers/fpga/xrt/lib/xleaf/vsec.c
> new file mode 100644
> index 000000000000..2bc7578c5f5d
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/vsec.c
> @@ -0,0 +1,372 @@
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
> +#include <linux/regmap.h>
> +#include "metadata.h"
> +#include "xdevice.h"
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
> +	char		*compat;
ok
> +};
> +
> +static struct vsec_device vsec_devs[] = {
> +	{
> +		.type = VSEC_TYPE_UUID,
> +		.ep_name = XRT_MD_NODE_BLP_ROM,
> +		.size = VSEC_UUID_LEN,
> +		.compat = "vsec-uuid",
> +	},
> +	{
> +		.type = VSEC_TYPE_FLASH,
> +		.ep_name = XRT_MD_NODE_FLASH_VSEC,
> +		.size = 4096,
> +		.compat = "vsec-flash",
> +	},
> +	{
> +		.type = VSEC_TYPE_PLATINFO,
> +		.ep_name = XRT_MD_NODE_PLAT_INFO,
> +		.size = 4,
> +		.compat = "vsec-platinfo",
> +	},
> +	{
> +		.type = VSEC_TYPE_MAILBOX,
> +		.ep_name = XRT_MD_NODE_MAILBOX_VSEC,
> +		.size = 48,
> +		.compat = "vsec-mbx",
> +	},
> +};
> +
> +XRT_DEFINE_REGMAP_CONFIG(vsec_regmap_config);
ok
> +
> +struct xrt_vsec {
> +	struct xrt_device	*xdev;
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
> +	return (entry->bar_rev >> 4) & 0xf;
ok
> +}
> +
> +static inline u64 vsec_get_bar_off(struct xrt_vsec_entry *entry)
> +{
> +	return entry->off_lo | ((u64)entry->off_hi << 16);
> +}
> +
> +static inline u32 vsec_get_rev(struct xrt_vsec_entry *entry)
> +{
> +	return entry->bar_rev & 0xf;
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
> +static char *type2compat(u32 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
> +		if (vsec_devs[i].type == type)
> +			return (vsec_devs[i].compat);
> +	}
> +
> +	return NULL;
> +}
> +
> +static int xrt_vsec_add_node(struct xrt_vsec *vsec,
> +			     void *md_blob, struct xrt_vsec_entry *p_entry)
> +{
> +	struct xrt_md_endpoint ep;
> +	char compat_ver[64];
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
> +	snprintf(compat_ver, sizeof(compat_ver) - 1, "%d-%d.%d.%d",
> +		 p_entry->ver_type, p_entry->major, p_entry->minor,
> +		 vsec_get_rev(p_entry));
> +	ep.ep_name = type2epname(p_entry->type);
> +	ep.bar_index = vsec_get_bar(p_entry);
> +	ep.bar_off = vsec_get_bar_off(p_entry);
> +	ep.size = type2size(p_entry->type);
> +	ep.compat = type2compat(p_entry->type);
> +	ep.compat_ver = compat_ver;
> +	ret = xrt_md_add_endpoint(DEV(vsec->xdev), vsec->metadata, &ep);
> +	if (ret)
> +		xrt_err(vsec->xdev, "add ep failed, ret %d", ret);
> +
> +	return ret;
> +}
> +
> +static int xrt_vsec_create_metadata(struct xrt_vsec *vsec)
> +{
> +	struct xrt_vsec_entry entry;
> +	int i, ret;
> +
> +	ret = xrt_md_create(&vsec->xdev->dev, &vsec->metadata);
> +	if (ret) {
> +		xrt_err(vsec->xdev, "create metadata failed");
> +		return ret;
> +	}
> +
> +	for (i = 0; i * sizeof(entry) < vsec->length -
> +	    sizeof(struct xrt_vsec_header); i++) {
> +		ret = vsec_read_entry(vsec, i, &entry);
> +		if (ret) {
> +			xrt_err(vsec->xdev, "failed read entry %d, ret %d", i, ret);
> +			goto fail;
> +		}
> +
> +		if (entry.type == VSEC_TYPE_END)
> +			break;
> +		ret = xrt_vsec_add_node(vsec, vsec->metadata, &entry);
> +		if (ret)
> +			goto fail;
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
> +static int xrt_vsec_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
> +{
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Does not handle any event. */
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		xrt_err(xdev, "should never been called");
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int xrt_vsec_mapio(struct xrt_vsec *vsec)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(vsec->xdev);
> +	struct resource *res = NULL;
> +	void __iomem *base = NULL;
> +	const u64 *bar_off;
> +	const u32 *bar;
> +	u64 addr;
> +	int ret;
> +
> +	if (!pdata || xrt_md_size(DEV(vsec->xdev), pdata->xsp_dtb) == XRT_MD_INVALID_LENGTH) {
> +		xrt_err(vsec->xdev, "empty metadata");
> +		return -EINVAL;
> +	}
> +
> +	ret = xrt_md_get_prop(DEV(vsec->xdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
> +			      NULL, XRT_MD_PROP_BAR_IDX, (const void **)&bar, NULL);
> +	if (ret) {
> +		xrt_err(vsec->xdev, "failed to get bar idx, ret %d", ret);
> +		return -EINVAL;
> +	}
> +
> +	ret = xrt_md_get_prop(DEV(vsec->xdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
> +			      NULL, XRT_MD_PROP_OFFSET, (const void **)&bar_off, NULL);
> +	if (ret) {
> +		xrt_err(vsec->xdev, "failed to get bar off, ret %d", ret);
> +		return -EINVAL;
> +	}
> +
> +	xrt_info(vsec->xdev, "Map vsec at bar %d, offset 0x%llx",
> +		 be32_to_cpu(*bar), be64_to_cpu(*bar_off));
> +
> +	xleaf_get_root_res(vsec->xdev, be32_to_cpu(*bar), &res);
> +	if (!res) {
> +		xrt_err(vsec->xdev, "failed to get bar addr");
> +		return -EINVAL;
> +	}
> +
> +	addr = res->start + be64_to_cpu(*bar_off);
> +
> +	base = devm_ioremap(&vsec->xdev->dev, addr, vsec_regmap_config.max_register);
> +	if (!base) {
> +		xrt_err(vsec->xdev, "Map failed");
> +		return -EIO;
> +	}
> +
> +	vsec->regmap = devm_regmap_init_mmio(&vsec->xdev->dev, base, &vsec_regmap_config);
> +	if (IS_ERR(vsec->regmap)) {
> +		xrt_err(vsec->xdev, "regmap %pR failed", res);
> +		return PTR_ERR(vsec->regmap);
> +	}
> +
> +	ret = regmap_read(vsec->regmap, VSEC_REG_LENGTH, &vsec->length);
> +	if (ret) {
> +		xrt_err(vsec->xdev, "failed to read length %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void xrt_vsec_remove(struct xrt_device *xdev)
> +{
> +	struct xrt_vsec	*vsec;
> +
> +	vsec = xrt_get_drvdata(xdev);
> +
> +	if (vsec->group >= 0)
> +		xleaf_destroy_group(xdev, vsec->group);
> +	vfree(vsec->metadata);
> +}
> +
> +static int xrt_vsec_probe(struct xrt_device *xdev)
> +{
> +	struct xrt_vsec	*vsec;
> +	int ret = 0;
> +
> +	vsec = devm_kzalloc(&xdev->dev, sizeof(*vsec), GFP_KERNEL);
> +	if (!vsec)
> +		return -ENOMEM;
> +
> +	vsec->xdev = xdev;
> +	vsec->group = -1;
> +	xrt_set_drvdata(xdev, vsec);
> +
> +	ret = xrt_vsec_mapio(vsec);
> +	if (ret)
> +		goto failed;
> +
> +	ret = xrt_vsec_create_metadata(vsec);
> +	if (ret) {
> +		xrt_err(xdev, "create metadata failed, ret %d", ret);
> +		goto failed;
> +	}
> +	ret = xleaf_create_group(xdev, vsec->metadata);

ok

Reviewed-by: Tom Rix <trix@redhat.com>

> +	if (ret < 0) {
> +		xrt_err(xdev, "create group failed, ret %d", vsec->group);
> +		goto failed;
> +	}
> +	vsec->group = ret;
> +
> +	return 0;
> +
> +failed:
> +	xrt_vsec_remove(xdev);
> +
> +	return ret;
> +}
> +
> +static struct xrt_dev_endpoints xrt_vsec_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_dev_ep_names []){
> +			{ .ep_name = XRT_MD_NODE_VSEC },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_driver xrt_vsec_driver = {
> +	.driver = {
> +		.name = XRT_VSEC,
> +	},
> +	.subdev_id = XRT_SUBDEV_VSEC,
> +	.endpoints = xrt_vsec_endpoints,
> +	.probe = xrt_vsec_probe,
> +	.remove = xrt_vsec_remove,
> +	.leaf_call = xrt_vsec_leaf_call,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(vsec);

