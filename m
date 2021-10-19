Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350D6433126
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Oct 2021 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhJSIjN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Oct 2021 04:39:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:6792 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJSIjN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Oct 2021 04:39:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="225919368"
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="225919368"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 01:37:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="483135657"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2021 01:36:57 -0700
Date:   Tue, 19 Oct 2021 16:30:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, yliu@xilinx.com,
        michal.simek@xilinx.com, stefanos@xilinx.com,
        devicetree@vger.kernel.org, trix@redhat.com, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V9 XRT Alveo 03/14] fpga: xrt: xclbin file helper
 functions
Message-ID: <20211019083026.GD40070@yilunxu-OptiPlex-7050>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
 <20210802160521.331031-4-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802160521.331031-4-lizhi.hou@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 02, 2021 at 09:05:10AM -0700, Lizhi Hou wrote:
> Alveo FPGA firmware and partial reconfigure file are in xclbin format. This
> code enumerates and extracts sections from xclbin files. xclbin.h is cross
> platform and used across all platforms and OS.
> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/xrt/include/xclbin-helper.h |  48 +++
>  drivers/fpga/xrt/lib/xclbin.c            | 381 ++++++++++++++++++++
>  include/uapi/linux/fpga-xrt.h            | 428 +++++++++++++++++++++++
>  3 files changed, 857 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>  create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>  create mode 100644 include/uapi/linux/fpga-xrt.h
> 
> diff --git a/drivers/fpga/xrt/include/xclbin-helper.h b/drivers/fpga/xrt/include/xclbin-helper.h
> new file mode 100644
> index 000000000000..518d55f74c25
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xclbin-helper.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *    David Zhang <davidzha@xilinx.com>
> + *    Sonal Santan <sonal.santan@xilinx.com>
> + */
> +
> +#ifndef _XCLBIN_HELPER_H_
> +#define _XCLBIN_HELPER_H_
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/fpga-xrt.h>
> +
> +#define XCLBIN_VERSION2	"xclbin2"
> +#define XCLBIN_HWICAP_BITFILE_BUF_SZ 1024
> +#define XCLBIN_MAX_SZ_1G (1024 * 1024 * 1024) /* Assuming xclbin <= 1G, always */
> +
> +enum axlf_section_kind;
> +struct axlf;
> +
> +/**
> + * Bitstream header information as defined by Xilinx tools.
> + * Please note that this struct definition is not owned by the driver.
> + */
> +struct xclbin_bit_head_info {
> +	u32 header_length;		/* Length of header in 32 bit words */
> +	u32 bitstream_length;		/* Length of bitstream to read in bytes */
> +	const unchar *design_name;	/* Design name get from bitstream */
> +	const unchar *part_name;	/* Part name read from bitstream */
> +	const unchar *date;		/* Date read from bitstream header */
> +	const unchar *time;		/* Bitstream creation time */
> +	u32 magic_length;		/* Length of the magic numbers */
> +	const unchar *version;		/* Version string */
> +};
> +
> +/* caller must free the allocated memory for **data. len could be NULL. */
> +int xrt_xclbin_get_section(struct device *dev,  const struct axlf *xclbin,
> +			   enum axlf_section_kind kind, void **data,
> +			   uint64_t *len);
> +int xrt_xclbin_get_metadata(struct device *dev, const struct axlf *xclbin, char **dtb);
> +int xrt_xclbin_parse_bitstream_header(struct device *dev, const unchar *data,
> +				      u32 size, struct xclbin_bit_head_info *head_info);
> +const char *xrt_clock_type2epname(enum XCLBIN_CLOCK_TYPE type);
> +
> +#endif /* _XCLBIN_HELPER_H_ */
> diff --git a/drivers/fpga/xrt/lib/xclbin.c b/drivers/fpga/xrt/lib/xclbin.c
> new file mode 100644
> index 000000000000..6edac3d418be
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xclbin.c
> @@ -0,0 +1,381 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Driver XCLBIN parser
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors: David Zhang <davidzha@xilinx.com>
> + */
> +
> +#include <asm/errno.h>
> +#include <linux/vmalloc.h>
> +#include <linux/device.h>
> +#include "xclbin-helper.h"
> +#include "metadata.h"
> +
> +/* Used for parsing bitstream header */
> +#define BITSTREAM_EVEN_MAGIC_BYTE	0x0f
> +#define BITSTREAM_ODD_MAGIC_BYTE	0xf0
> +
> +static inline u16 bitstream_read16(const char *data, u32 *offset)
> +{
> +	u16 val;
> +
> +	val = be16_to_cpu(*(__be16 *)(data + *offset));
> +	*offset += sizeof(__be16);
> +
> +	return val;
> +}
> +
> +static inline u32 bitstream_read32(const char *data, u32 *offset)
> +{
> +	u32 val;
> +
> +	val = be32_to_cpu(*(__be32 *)(data + *offset));
> +	*offset += sizeof(__be32);
> +
> +	return val;
> +}
> +
> +static int xrt_xclbin_get_section_hdr(const struct axlf *xclbin,
> +				      enum axlf_section_kind kind,
> +				      const struct axlf_section_header **header)
> +{
> +	const struct axlf_section_header *phead = NULL;
> +	u64 xclbin_len;
> +	int i;
> +
> +	*header = NULL;
> +	for (i = 0; i < xclbin->header.num_sections; i++) {
> +		if (xclbin->sections[i].section_kind == kind) {
> +			phead = &xclbin->sections[i];
> +			break;
> +		}
> +	}
> +
> +	if (!phead)
> +		return -ENOENT;
> +
> +	xclbin_len = xclbin->header.length;
> +	if (xclbin_len > XCLBIN_MAX_SZ_1G || !phead->section_size ||
> +	    phead->section_offset + phead->section_size > xclbin_len)
> +		return -EINVAL;
> +
> +	*header = phead;
> +	return 0;
> +}
> +
> +static int xrt_xclbin_section_info(const struct axlf *xclbin,
> +				   enum axlf_section_kind kind,
> +				   u64 *offset, u64 *size)
> +{
> +	const struct axlf_section_header *mem_header = NULL;
> +	int rc;
> +
> +	rc = xrt_xclbin_get_section_hdr(xclbin, kind, &mem_header);
> +	if (rc)
> +		return rc;
> +
> +	*offset = mem_header->section_offset;
> +	*size = mem_header->section_size;
> +
> +	return 0;
> +}
> +
> +/* caller must free the allocated memory for **data */
> +int xrt_xclbin_get_section(struct device *dev,
> +			   const struct axlf *buf,
> +			   enum axlf_section_kind kind,
> +			   void **data, u64 *len)
> +{
> +	const struct axlf *xclbin = (const struct axlf *)buf;
> +	void *section = NULL;
> +	u64 offset;
> +	u64 size;
> +	int err;
> +
> +	if (!data) {
> +		dev_err(dev, "invalid data pointer");
> +		return -EINVAL;
> +	}
> +
> +	err = xrt_xclbin_section_info(xclbin, kind, &offset, &size);
> +	if (err) {
> +		dev_dbg(dev, "parsing section failed. kind %d, err = %d", kind, err);
> +		return err;
> +	}
> +
> +	section = vzalloc(size);
> +	if (!section)
> +		return -ENOMEM;
> +
> +	memcpy(section, ((const char *)xclbin) + offset, size);
> +
> +	*data = section;
> +	if (len)
> +		*len = size;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_xclbin_get_section);
> +
> +static inline int xclbin_bit_get_string(const unchar *data, u32 size,
> +					u32 offset, unchar prefix,
> +					const unchar **str)
> +{
> +	int len;
> +	u32 tmp;
> +
> +	/* prefix and length will be 3 bytes */
> +	if (offset + 3  > size)
> +		return -EINVAL;
> +
> +	/* Read prefix */
> +	tmp = data[offset++];
> +	if (tmp != prefix)
> +		return -EINVAL;
> +
> +	/* Get string length */
> +	len = bitstream_read16(data, &offset);
> +	if (offset + len > size)
> +		return -EINVAL;
> +
> +	if (data[offset + len - 1] != '\0')
> +		return -EINVAL;
> +
> +	*str = data + offset;
> +
> +	return len + 3;
> +}
> +
> +/* parse bitstream header */
> +int xrt_xclbin_parse_bitstream_header(struct device *dev, const unchar *data,
> +				      u32 size, struct xclbin_bit_head_info *head_info)
> +{
> +	u32 offset = 0;
> +	int len, i;
> +	u16 magic;
> +
> +	memset(head_info, 0, sizeof(*head_info));
> +
> +	/* Get "Magic" length */
> +	if (size < sizeof(u16)) {
> +		dev_err(dev, "invalid size");
> +		return -EINVAL;
> +	}
> +
> +	len = bitstream_read16(data, &offset);
> +	if (offset + len > size) {
> +		dev_err(dev, "invalid magic len");
> +		return -EINVAL;
> +	}
> +	head_info->magic_length = len;
> +
> +	for (i = 0; i < head_info->magic_length - 1; i++) {
> +		magic = data[offset++];
> +		if (!(i % 2) && magic != BITSTREAM_EVEN_MAGIC_BYTE) {
> +			dev_err(dev, "invalid magic even byte at %d", offset);
> +			return -EINVAL;
> +		}
> +
> +		if ((i % 2) && magic != BITSTREAM_ODD_MAGIC_BYTE) {
> +			dev_err(dev, "invalid magic odd byte at %d", offset);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (offset + 3 > size) {
> +		dev_err(dev, "invalid length of magic end");
> +		return -EINVAL;
> +	}
> +	/* Read null end of magic data. */
> +	if (data[offset++]) {
> +		dev_err(dev, "invalid magic end");
> +		return -EINVAL;
> +	}
> +
> +	/* Read 0x01 (short) */
> +	magic = bitstream_read16(data, &offset);
> +
> +	/* Check the "0x01" half word */
> +	if (magic != 0x01) {
> +		dev_err(dev, "invalid magic end");
> +		return -EINVAL;
> +	}
> +
> +	len = xclbin_bit_get_string(data, size, offset, 'a', &head_info->design_name);
> +	if (len < 0) {
> +		dev_err(dev, "get design name failed");
> +		return -EINVAL;
> +	}
> +
> +	head_info->version = strstr(head_info->design_name, "Version=") + strlen("Version=");
> +	offset += len;
> +
> +	len = xclbin_bit_get_string(data, size, offset, 'b', &head_info->part_name);
> +	if (len < 0) {
> +		dev_err(dev, "get part name failed");
> +		return -EINVAL;
> +	}
> +	offset += len;
> +
> +	len = xclbin_bit_get_string(data, size, offset, 'c', &head_info->date);
> +	if (len < 0) {
> +		dev_err(dev, "get data failed");
> +		return -EINVAL;
> +	}
> +	offset += len;
> +
> +	len = xclbin_bit_get_string(data, size, offset, 'd', &head_info->time);
> +	if (len < 0) {
> +		dev_err(dev, "get time failed");
> +		return -EINVAL;
> +	}
> +	offset += len;
> +
> +	if (offset + 5 >= size) {
> +		dev_err(dev, "can not get bitstream length");
> +		return -EINVAL;
> +	}
> +
> +	/* Read 'e' */
> +	if (data[offset++] != 'e') {
> +		dev_err(dev, "invalid prefix of bitstream length");
> +		return -EINVAL;
> +	}
> +
> +	/* Get byte length of bitstream */
> +	head_info->bitstream_length = bitstream_read32(data, &offset);
> +
> +	head_info->header_length = offset;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_xclbin_parse_bitstream_header);
> +
> +static struct xrt_clock_desc {
> +	char	*clock_ep_name;
> +	u32	clock_xclbin_type;
> +	char	*clkfreq_ep_name;
> +} clock_desc[] = {
> +	{
> +		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL1,
> +		.clock_xclbin_type = CT_DATA,
> +		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_K1,
> +	},
> +	{
> +		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL2,
> +		.clock_xclbin_type = CT_KERNEL,
> +		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_K2,
> +	},
> +	{
> +		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL3,
> +		.clock_xclbin_type = CT_SYSTEM,
> +		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_HBM,
> +	},
> +};
> +
> +const char *xrt_clock_type2epname(enum XCLBIN_CLOCK_TYPE type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
> +		if (clock_desc[i].clock_xclbin_type == type)
> +			return clock_desc[i].clock_ep_name;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(xrt_clock_type2epname);
> +
> +static const char *clock_type2clkfreq_name(enum XCLBIN_CLOCK_TYPE type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
> +		if (clock_desc[i].clock_xclbin_type == type)
> +			return clock_desc[i].clkfreq_ep_name;
> +	}
> +	return NULL;
> +}
> +
> +static int xrt_xclbin_add_clock_metadata(struct device *dev,
> +					 const struct axlf *xclbin,
> +					 char *dtb)
> +{
> +	struct clock_freq_topology *clock_topo;
> +	u16 freq;
> +	int rc;
> +	int i;
> +
> +	/* if clock section does not exist, add nothing and return success */
> +	rc = xrt_xclbin_get_section(dev, xclbin, CLOCK_FREQ_TOPOLOGY,
> +				    (void **)&clock_topo, NULL);
> +	if (rc == -ENOENT)
> +		return 0;
> +	else if (rc)
> +		return rc;
> +
> +	for (i = 0; i < clock_topo->count; i++) {
> +		u8 type = clock_topo->clock_freq[i].type;
> +		const char *ep_name = xrt_clock_type2epname(type);
> +		const char *counter_name = clock_type2clkfreq_name(type);
> +
> +		if (!ep_name || !counter_name)
> +			continue;
> +
> +		freq = be16_to_cpu((__force __be16)clock_topo->clock_freq[i].freq_MHZ);
> +		rc = xrt_md_set_prop(dev, dtb, ep_name, NULL, XRT_MD_PROP_CLK_FREQ,
> +				     &freq, sizeof(freq));
> +		if (rc)
> +			break;
> +
> +		rc = xrt_md_set_prop(dev, dtb, ep_name, NULL, XRT_MD_PROP_CLK_CNT,
> +				     counter_name, strlen(counter_name) + 1);
> +		if (rc)
> +			break;
> +	}
> +
> +	vfree(clock_topo);
> +
> +	return rc;
> +}
> +
> +int xrt_xclbin_get_metadata(struct device *dev, const struct axlf *xclbin, char **dtb)
> +{
> +	char *md = NULL, *newmd = NULL;
> +	u64 len, md_len;
> +	int rc;
> +
> +	*dtb = NULL;
> +
> +	rc = xrt_xclbin_get_section(dev, xclbin, PARTITION_METADATA, (void **)&md, &len);
> +	if (rc)
> +		goto done;
> +
> +	md_len = xrt_md_size(dev, md);
> +
> +	/* Sanity check the dtb section. */
> +	if (md_len > len) {
> +		rc = -EINVAL;
> +		goto done;
> +	}
> +
> +	/* use dup function here to convert incoming metadata to writable */
> +	newmd = xrt_md_dup(dev, md);
> +	if (!newmd) {
> +		rc = -EFAULT;
> +		goto done;
> +	}
> +
> +	/* Convert various needed xclbin sections into dtb. */
> +	rc = xrt_xclbin_add_clock_metadata(dev, xclbin, newmd);
> +
> +	if (!rc)
> +		*dtb = newmd;
> +	else
> +		vfree(newmd);
> +done:
> +	vfree(md);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(xrt_xclbin_get_metadata);
> diff --git a/include/uapi/linux/fpga-xrt.h b/include/uapi/linux/fpga-xrt.h
> new file mode 100644
> index 000000000000..ace7d3d09897
> --- /dev/null
> +++ b/include/uapi/linux/fpga-xrt.h
> @@ -0,0 +1,428 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + *  Xilinx FPGA compiled binary container format
> + *
> + *  Copyright (C) 2015-2021, Xilinx Inc
> + */
> +
> +#ifndef _UAPI_LINUX_FPGA_XRT_H
> +#define _UAPI_LINUX_FPGA_XRT_H
> +
> +#if defined(__KERNEL__)
> +
> +#include <linux/types.h>
> +
> +#elif defined(__cplusplus)
> +
> +#include <cstdlib>
> +#include <cstdint>
> +#include <algorithm>
> +#include <uuid/uuid.h>
> +
> +#else
> +
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <uuid/uuid.h>
> +
> +#endif
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <linux/ioctl.h>
> +
> +/**
> + * DOC: Container format for Xilinx FPGA images
> + * The container stores bitstreams, metadata and firmware images.
> + * xclbin/xsabin is an ELF-like binary container format. It is a structured

I guess the format is called axlf? If yes, please add it. I was wondering
what the axlf_ structures stand for.

> + * series of sections. There is a file header followed by several section
> + * headers which is followed by sections. A section header points to an
> + * actual section. There is an optional signature at the end. The
> + * following figure illustrates a typical xclbin:
> + *
> + *     +---------------------+
> + *     |                     |
> + *     |       HEADER        |
> + *     +---------------------+
> + *     |   SECTION  HEADER   |
> + *     |                     |
> + *     +---------------------+
> + *     |        ...          |
> + *     |                     |
> + *     +---------------------+
> + *     |   SECTION  HEADER   |
> + *     |                     |
> + *     +---------------------+
> + *     |       SECTION       |
> + *     |                     |
> + *     +---------------------+
> + *     |         ...         |
> + *     |                     |
> + *     +---------------------+
> + *     |       SECTION       |
> + *     |                     |
> + *     +---------------------+
> + *     |      SIGNATURE      |
> + *     |      (OPTIONAL)     |
> + *     +---------------------+
> + */
> +
> +enum XCLBIN_MODE {
> +	XCLBIN_FLAT = 0,
> +	XCLBIN_PR,
> +	XCLBIN_TANDEM_STAGE2,
> +	XCLBIN_TANDEM_STAGE2_WITH_PR,
> +	XCLBIN_HW_EMU,
> +	XCLBIN_SW_EMU,
> +	XCLBIN_MODE_MAX
> +};
> +
> +enum axlf_section_kind {
> +	BITSTREAM = 0,
> +	CLEARING_BITSTREAM,
> +	EMBEDDED_METADATA,
> +	FIRMWARE,
> +	DEBUG_DATA,
> +	SCHED_FIRMWARE,
> +	MEM_TOPOLOGY,
> +	CONNECTIVITY,
> +	IP_LAYOUT,
> +	DEBUG_IP_LAYOUT,
> +	DESIGN_CHECK_POINT,
> +	CLOCK_FREQ_TOPOLOGY,
> +	MCS,
> +	BMC,
> +	BUILD_METADATA,
> +	KEYVALUE_METADATA,
> +	USER_METADATA,
> +	DNA_CERTIFICATE,
> +	PDI,
> +	BITSTREAM_PARTIAL_PDI,
> +	PARTITION_METADATA,
> +	EMULATION_DATA,
> +	SYSTEM_METADATA,
> +	SOFT_KERNEL,
> +	ASK_FLASH,
> +	AIE_METADATA,
> +	ASK_GROUP_TOPOLOGY,
> +	ASK_GROUP_CONNECTIVITY
> +};
> +
> +enum MEM_TYPE {
> +	MEM_DDR3 = 0,
> +	MEM_DDR4,
> +	MEM_DRAM,
> +	MEM_STREAMING,
> +	MEM_PREALLOCATED_GLOB,
> +	MEM_ARE,
> +	MEM_HBM,
> +	MEM_BRAM,
> +	MEM_URAM,
> +	MEM_STREAMING_CONNECTION
> +};
> +
> +enum IP_TYPE {
> +	IP_MB = 0,
> +	IP_KERNEL,
> +	IP_DNASC,
> +	IP_DDR4_CONTROLLER,
> +	IP_MEM_DDR4,
> +	IP_MEM_HBM
> +};
> +
> +struct axlf_section_header {
> +	uint32_t section_kind;			/* Section type */
> +	char section_name[16];			/* Section name */
> +	char rsvd[4];
> +	uint64_t section_offset;		/* File offset of section data */
> +	uint64_t section_size;			/* Size of section data */
> +} __packed;
> +
> +struct axlf_header {
> +	uint64_t length;			/* Total size of the xclbin file */
> +	uint64_t time_stamp;			/* Timestamp when xclbin was created */
> +	uint64_t feature_rom_timestamp;		/* TimeSinceEpoch of the featureRom */
> +	uint16_t version_patch;			/* Patch Version */
> +	uint8_t version_major;			/* Major Version */
> +	uint8_t version_minor;			/* Minor Version */
> +	uint32_t mode;				/* Xclbin mode. See enum XCLBIN_MODE */
> +	union {
> +		struct {
> +			uint64_t platform_id;	/* 64 bit platform ID */
> +			uint64_t feature_id;	/* 64 bit feature ID */
> +		} rom;
> +		unsigned char rom_uuid[16];	/* feature ROM UUID */
> +	};
> +	unsigned char platform_vbnv[64];	/* String of Vendor:Board:Name:Version */
> +	union {
> +		char next_axlf[16];		/* Name of next xclbin file */
> +		unsigned char uuid[16];		/* uuid of this xclbin */
> +	};
> +	char debug_bin[16];			/* Name of binary with debug information */
> +	uint32_t num_sections;			/* Number of section headers */
> +	char rsvd[4];
> +} __packed;
> +
> +struct axlf {
> +	char magic[8];				/* Magic word: xclbin2\0 */
> +	int32_t signature_length;		/* Length. -1 indicates no signature */
> +	uint8_t reserved[28];
> +	uint8_t key_block[256];			/* Signature for validation of binary */
> +	uint64_t unique_id;			/* Unique ID */
> +	struct axlf_header header;		/* Inline header */
> +	struct axlf_section_header sections[1];	/* One or more section headers follow */
> +} __packed;
> +
> +/* bitstream information */
> +struct xlnx_bitstream {
> +	uint8_t freq[8];
> +	char bits[1];
> +} __packed;
> +
> +/****	MEMORY TOPOLOGY SECTION ****/
> +struct mem_data {
> +	uint8_t type;				/* Memory type. See enum MEM_TYPE */
> +	uint8_t used;				/* Memory presence. 0 means not present */
> +	uint8_t rsvd[6];
> +	union {
> +		uint64_t size;			/* Memory size. Counted in KB */
> +		uint64_t route_id;		/* Stream route ID */
> +	};
> +	union {
> +		uint64_t base_address;		/* Memory base address */
> +		uint64_t flow_id;		/* Stream flow ID */
> +	};
> +	unsigned char tag[16];			/* Memory tag string */
> +} __packed;
> +
> +struct mem_topology {
> +	int32_t count;				/* Number of mem_data */
> +	struct mem_data mem_data[1];		/* mem_data array, sorted on mem_type */
> +} __packed;
> +
> +/****	CONNECTIVITY SECTION ****/
> +/* Connectivity of each argument of CU(Compute Unit). It will be in terms
> + * of argument index associated. For associating CU instances with arguments
> + * and banks, start at the connectivity section. Using the ip_layout_index
> + * access the ip_data.name. Now we can associate this CU instance with its
> + * original CU name and get the connectivity as well. This enables us to form
> + * related groups of CU instances.
> + */
> +
> +struct connection {
> +	int32_t arg_index;			/* Index of CU argument */
> +	int32_t ip_layout_index;		/* Index into the ip_layout section */
> +	int32_t mem_data_index;			/* Index into the mem_data section */
> +} __packed;
> +
> +struct connectivity {
> +	int32_t count;
> +	struct connection connection[1];
> +} __packed;
> +
> +/****	IP_LAYOUT SECTION ****/
> +
> +/* IP Kernel */
> +#define IP_INT_ENABLE_MASK	  0x0001
> +#define IP_INTERRUPT_ID_MASK  0x00FE
> +#define IP_INTERRUPT_ID_SHIFT 0x1
> +
> +enum IP_CONTROL {
> +	AP_CTRL_HS = 0,
> +	AP_CTRL_CHAIN,
> +	AP_CTRL_NONE,
> +	AP_CTRL_ME,
> +	ACCEL_ADAPTER
> +};
> +
> +#define IP_CONTROL_MASK	 0xFF00
> +#define IP_CONTROL_SHIFT 0x8
> +
> +/*
> + * IPs on AXI lite - their types, names, and base addresses.
> + *
> + * The defination of 32-bit follows IP_TYPE is based on IP_TYPE
> + *   For IP_KERNEL
> + *	    int_enable   : Bit  - 0x0000_0001;
> + *	    interrupt_id : Bits - 0x0000_00FE;
> + *	    ip_control   : Bits - 0x0000_FF00;
> + *   For IP_MEM_*
> + *	    index        : Bits - 0x0000_FFFF;
> + *	    pc_index     : Bits - 0x00FF_0000;
> + */
> +struct ip_data {
> +	uint32_t type;				/* Type. See enum IP_TYPE */
> +	union {
> +		uint32_t properties;
> +		struct {
> +			uint16_t index;
> +			uint8_t pc_index;
> +			uint8_t unused;
> +		} indices;
> +	};
> +	uint64_t base_address;
> +	uint8_t name[64];			/* Name of IP */
> +} __packed;
> +
> +struct ip_layout {
> +	int32_t count;
> +	struct ip_data ip_data[1];		/* ip_data array, sorted by base_address */
> +} __packed;
> +
> +/*** Debug IP section layout ****/
> +enum DEBUG_IP_TYPE {
> +	UNDEFINED = 0,
> +	LAPC,
> +	ILA,
> +	AXI_MM_MONITOR,
> +	AXI_TRACE_FUNNEL,
> +	AXI_MONITOR_FIFO_LITE,
> +	AXI_MONITOR_FIFO_FULL,
> +	ACCEL_MONITOR,
> +	AXI_STREAM_MONITOR,
> +	AXI_STREAM_PROTOCOL_CHECKER,
> +	TRACE_S2MM,
> +	AXI_DMA,
> +	TRACE_S2MM_FULL
> +};
> +
> +struct debug_ip_data {
> +	uint8_t type;				/* Type. See enum DEBUG_IP_TYPE */
> +	uint8_t index_lowbyte;
> +	uint8_t properties;
> +	uint8_t major;
> +	uint8_t minor;
> +	uint8_t index_highbyte;
> +	uint8_t reserved[2];
> +	uint64_t base_address;
> +	char	name[128];
> +} __packed;
> +
> +struct debug_ip_layout {
> +	uint16_t count;
> +	struct debug_ip_data debug_ip_data[1];
> +} __packed;
> +
> +/* Supported clock frequency types */
> +enum XCLBIN_CLOCK_TYPE {
> +	CT_UNUSED = 0,				/* Initialized value */
> +	CT_DATA	  = 1,				/* Data clock */
> +	CT_KERNEL = 2,				/* Kernel clock */
> +	CT_SYSTEM = 3				/* System Clock */
> +};
> +
> +/* Clock Frequency Entry */
> +struct clock_freq {
> +	uint16_t freq_MHZ;			/* Frequency in MHz */
> +	uint8_t type;				/* Clock type (enum CLOCK_TYPE) */
> +	uint8_t unused[5];
> +	char name[128];				/* Clock Name */
> +} __packed;
> +
> +/* Clock frequency section */
> +struct clock_freq_topology {
> +	int16_t count;				/* Number of entries */
> +	struct clock_freq clock_freq[1];	/* Clock array */
> +} __packed;
> +
> +/* Supported MCS file types */
> +enum MCS_TYPE {
> +	MCS_UNKNOWN = 0,			/* Initialized value */
> +	MCS_PRIMARY = 1,			/* The primary mcs file data */
> +	MCS_SECONDARY = 2,			/* The secondary mcs file data */
> +};
> +
> +/* One chunk of MCS data */
> +struct mcs_chunk {
> +	uint8_t type;				/* MCS data type */
> +	uint8_t unused[7];
> +	uint64_t offset;			/* Data offset */
> +	uint64_t size;				/* Data size */
> +} __packed;
> +
> +/* MCS data section */
> +struct mcs {
> +	int8_t count;				/* Number of chunks */
> +	int8_t unused[7];
> +	struct mcs_chunk chunk[1];		/* MCS chunks followed by data */
> +} __packed;
> +
> +/* bmc data section */
> +struct bmc {
> +	uint64_t offset;			/* Data offset */
> +	uint64_t size;				/* Data size (bytes) */
> +	char image_name[64];			/* Name of the image */
> +	char device_name[64];			/* Name of the device */
> +	char version[64];
> +	char md5value[33];			/* MD5 checksum */
> +	char padding[7];
> +} __packed;
> +
> +/*
> + * soft kernel data section, used by classic driver
> + * Prefix Syntax:
> + *  mpo - member, pointer, offset
> + *  This variable represents a zero terminated string
> + *  that is offseted from the beginning of the section.
> + *  The pointer to access the string is initialized as follows:
> + *  char * pCharString = (address_of_section) + (mpo value)
> + */
> +struct soft_kernel {
> +	uint32_t mpo_name;			/* Name of the soft kernel */
> +	uint32_t image_offset;			/* Image offset */
> +	uint32_t image_size;			/* Image size */
> +	uint32_t mpo_version;			/* Version */
> +	uint32_t mpo_md5_value;			/* MD5 checksum */
> +	uint32_t mpo_symbol_name;		/* Symbol name */
> +	uint32_t num_instances;			/* Number of instances */
> +	uint8_t padding[36];			/* Reserved for future use */
> +	uint8_t reserved_ext[16];		/* Reserved for future extended data */
> +} __packed;
> +
> +enum CHECKSUM_TYPE {
> +	CST_UNKNOWN = 0,
> +	CST_SDBM = 1,
> +	CST_LAST
> +};
> +
> +/**
> + * DOC: PCIe Kernel Driver for Management Physical Function
> + * Interfaces exposed by *xrt-mgmt* driver are defined in file, *xmgmt-ioctl.h*.
> + * Core functionality provided by *xrt-mgmt* driver is described in the following table:
> + *
> + * =========== ============================== ==================================
> + * Functionality           ioctl request code           data format
> + * =========== ============================== ==================================
> + * 1 FPGA image download   XMGMT_IOCICAPDOWNLOAD_AXLF xmgmt_ioc_bitstream_axlf
> + * =========== ============================== ==================================

Seems the lines are not aligned with the text.

> + */
> +
> +#define XMGMT_IOC_MAGIC 'X'
> +#define XMGMT_IOC_ICAP_DOWNLOAD_AXLF 0x6
> +
> +/**
> + * struct xmgmt_ioc_bitstream_axlf - load xclbin (AXLF) device image
> + * used with XMGMT_IOCICAPDOWNLOAD_AXLF ioctl
> + *
> + * @xclbin:     Pointer to user's xclbin structure in memory
> + */
> +struct xmgmt_ioc_bitstream_axlf {
> +	struct axlf *xclbin;
> +};
> +
> +#define XMGMT_IOCICAPDOWNLOAD_AXLF                              \
> +	_IOW(XMGMT_IOC_MAGIC, XMGMT_IOC_ICAP_DOWNLOAD_AXLF, struct xmgmt_ioc_bitstream_axlf)
> +
> +/*
> + * The following definitions are for binary compatibility with classic XRT management driver
> + */
> +#define XCLMGMT_IOCICAPDOWNLOAD_AXLF XMGMT_IOCICAPDOWNLOAD_AXLF
> +#define xclmgmt_ioc_bitstream_axlf xmgmt_ioc_bitstream_axlf

I didn't see the 2 definitions used in the drivers. Could be removed?

Thanks,
Yilun

> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> -- 
> 2.27.0
