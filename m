Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAF134BCF1
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Mar 2021 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhC1PbQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Mar 2021 11:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230292AbhC1Pa7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 28 Mar 2021 11:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616945458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dj005Ca9Xa+RYpFLJf1/t12sfuNZaj1A6GFq2vHcUVk=;
        b=dAv/w6WbBalRS0cDFcSoPnVj4tA5fVj7hvrEUgZUp/pjg192QalVI56avsNAREG62v0vYI
        dRikmjCBsPt8xS42H85ERQ99JfiXZJs/i8gbIeV6XoClb6k8/SJg9ZmlGrNN7Hg+PxvCMt
        PrPKW6b85hcBknuIPryqzCTtnCSDMmg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-tZDcRIixMfCfYpBb4ooypw-1; Sun, 28 Mar 2021 11:30:56 -0400
X-MC-Unique: tZDcRIixMfCfYpBb4ooypw-1
Received: by mail-qv1-f71.google.com with SMTP id l16so3736517qvt.19
        for <linux-fpga@vger.kernel.org>; Sun, 28 Mar 2021 08:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Dj005Ca9Xa+RYpFLJf1/t12sfuNZaj1A6GFq2vHcUVk=;
        b=aKIO9vdZhb8wHZkOwp3IJW2u2bCjHu3i4BJnm91hjB8tgzMGar9wBlDVyPMSu+R+Ur
         6bFS9Vu5E470Id+QpYo8R/k3rbWC6EobLk3U940gdVuYGc8ybrhLrLhRdoN7yx5vyDF6
         VHQ9OQ/ijfl36uiBNeeaUBHAwZcv2zUqXmN2000Q0TVL5ApP4e+5uIIw9AtSq8eMBAt6
         cT6IUK6MNlpGZTACivjivFceZSsO5c5Hw/EBhZdipArYs3KKSHp8L1YSuhDJKQgiubWD
         ebvu+TBt4lvS8rAprjDcPyYahA8mvWF4WzyYT0z3pgoO6QT71M5+p2D1yR7vqL9DiB1h
         SSEg==
X-Gm-Message-State: AOAM531brMqJwwHp4dLx0/4ARCxcKQDnpH7VIpWj6xZsa+uhp4eXcYYh
        GHOEJto58oUwR72JO3utM/Gf6I/1oMU5ae2PXhhBoDrxb76fleN2EjNjYEDEFwSttSNRqcGz40N
        I04rx8WTPjFU4A+tby+yQBw==
X-Received: by 2002:a05:620a:553:: with SMTP id o19mr21724702qko.491.1616945455649;
        Sun, 28 Mar 2021 08:30:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTN6KxXWUb1ixjTKaQCVZ+KK6aHlJXWC/VSvbz3gw7PqEa/cuY2ZkliFgsnOGIFfL673jcig==
X-Received: by 2002:a05:620a:553:: with SMTP id o19mr21724662qko.491.1616945455255;
        Sun, 28 Mar 2021 08:30:55 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i17sm9520413qtr.33.2021.03.28.08.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 08:30:54 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 02/20] fpga: xrt: driver metadata helper
 functions
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-3-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d6fc7dbc-8a57-1e29-46bd-5129a39358b8@redhat.com>
Date:   Sun, 28 Mar 2021 08:30:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-3-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Do not reorder function definitions, this makes comparing changes from the previous patchset difficult.

A general issue with returning consistent error codes.  There are several cases where fdt_* code are not translated.

On 3/23/21 10:29 PM, Lizhi Hou wrote:
> XRT drivers use device tree as metadata format to discover HW subsystems
> behind PCIe BAR. Thus libfdt functions are called for the driver to parse
> device tree blob.
to parse the device
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/xrt/include/metadata.h  | 233 ++++++++++++
>  drivers/fpga/xrt/metadata/metadata.c | 545 +++++++++++++++++++++++++++
>  2 files changed, 778 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/metadata.h
>  create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>
> diff --git a/drivers/fpga/xrt/include/metadata.h b/drivers/fpga/xrt/include/metadata.h
> new file mode 100644
> index 000000000000..479e47960c61
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/metadata.h
> @@ -0,0 +1,233 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *      Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#ifndef _XRT_METADATA_H
> +#define _XRT_METADATA_H
> +
> +#include <linux/device.h>
> +#include <linux/vmalloc.h>
> +#include <linux/uuid.h>
> +
> +#define XRT_MD_INVALID_LENGTH (~0UL)
> +
> +/* metadata properties */
> +#define XRT_MD_PROP_BAR_IDX "pcie_bar_mapping"
> +#define XRT_MD_PROP_COMPATIBLE "compatible"
> +#define XRT_MD_PROP_HWICAP "axi_hwicap"
> +#define XRT_MD_PROP_INTERFACE_UUID "interface_uuid"
> +#define XRT_MD_PROP_INTERRUPTS "interrupts"
> +#define XRT_MD_PROP_IO_OFFSET "reg"
> +#define XRT_MD_PROP_LOGIC_UUID "logic_uuid"
> +#define XRT_MD_PROP_PDI_CONFIG "pdi_config_mem"
> +#define XRT_MD_PROP_PF_NUM "pcie_physical_function"
> +#define XRT_MD_PROP_VERSION_MAJOR "firmware_version_major"
> +
> +/* non IP nodes */
> +#define XRT_MD_NODE_ENDPOINTS "addressable_endpoints"
> +#define XRT_MD_NODE_FIRMWARE "firmware"
> +#define XRT_MD_NODE_INTERFACES "interfaces"
> +#define XRT_MD_NODE_PARTITION_INFO "partition_info"
> +
> +/*
> + * IP nodes
> + * AF:  AXI Firewall
> + * CMC: Card Management Controller
> + * ERT: Embedded Runtime
* EP: End Point
> + * PLP: Provider Reconfigurable Partition
> + * ULP: User Reconfigurable Partition
> + */
> +#define XRT_MD_NODE_ADDR_TRANSLATOR "ep_remap_data_c2h_00"
> +#define XRT_MD_NODE_AF_BLP_CTRL_MGMT "ep_firewall_blp_ctrl_mgmt_00"
> +#define XRT_MD_NODE_AF_BLP_CTRL_USER "ep_firewall_blp_ctrl_user_00"
> +#define XRT_MD_NODE_AF_CTRL_DEBUG "ep_firewall_ctrl_debug_00"
> +#define XRT_MD_NODE_AF_CTRL_MGMT "ep_firewall_ctrl_mgmt_00"
> +#define XRT_MD_NODE_AF_CTRL_USER "ep_firewall_ctrl_user_00"
> +#define XRT_MD_NODE_AF_DATA_C2H "ep_firewall_data_c2h_00"
c2h ?
> +#define XRT_MD_NODE_AF_DATA_H2C "ep_firewall_data_h2c_00"
> +#define XRT_MD_NODE_AF_DATA_M2M "ep_firewall_data_m2m_00"
> +#define XRT_MD_NODE_AF_DATA_P2P "ep_firewall_data_p2p_00"
> +#define XRT_MD_NODE_CLKFREQ_HBM "ep_freq_cnt_aclk_hbm_00"
> +#define XRT_MD_NODE_CLKFREQ_K1 "ep_freq_cnt_aclk_kernel_00"
> +#define XRT_MD_NODE_CLKFREQ_K2 "ep_freq_cnt_aclk_kernel_01"
> +#define XRT_MD_NODE_CLK_KERNEL1 "ep_aclk_kernel_00"
> +#define XRT_MD_NODE_CLK_KERNEL2 "ep_aclk_kernel_01"
> +#define XRT_MD_NODE_CLK_KERNEL3 "ep_aclk_hbm_00"

hbm ?

unusual acronyms should be documented.

> +#define XRT_MD_NODE_CLK_SHUTDOWN "ep_aclk_shutdown_00"
> +#define XRT_MD_NODE_CMC_FW_MEM "ep_cmc_firmware_mem_00"
> +#define XRT_MD_NODE_CMC_MUTEX "ep_cmc_mutex_00"
> +#define XRT_MD_NODE_CMC_REG "ep_cmc_regmap_00"
> +#define XRT_MD_NODE_CMC_RESET "ep_cmc_reset_00"
> +#define XRT_MD_NODE_DDR_CALIB "ep_ddr_mem_calib_00"
> +#define XRT_MD_NODE_DDR4_RESET_GATE "ep_ddr_mem_srsr_gate_00"
> +#define XRT_MD_NODE_ERT_BASE "ep_ert_base_address_00"
> +#define XRT_MD_NODE_ERT_CQ_MGMT "ep_ert_command_queue_mgmt_00"
> +#define XRT_MD_NODE_ERT_CQ_USER "ep_ert_command_queue_user_00"
> +#define XRT_MD_NODE_ERT_FW_MEM "ep_ert_firmware_mem_00"
> +#define XRT_MD_NODE_ERT_RESET "ep_ert_reset_00"
> +#define XRT_MD_NODE_ERT_SCHED "ep_ert_sched_00"
> +#define XRT_MD_NODE_FLASH "ep_card_flash_program_00"
> +#define XRT_MD_NODE_FPGA_CONFIG "ep_fpga_configuration_00"
> +#define XRT_MD_NODE_GAPPING "ep_gapping_demand_00"
> +#define XRT_MD_NODE_GATE_PLP "ep_pr_isolate_plp_00"
> +#define XRT_MD_NODE_GATE_ULP "ep_pr_isolate_ulp_00"
> +#define XRT_MD_NODE_KDMA_CTRL "ep_kdma_ctrl_00"
> +#define XRT_MD_NODE_MAILBOX_MGMT "ep_mailbox_mgmt_00"
> +#define XRT_MD_NODE_MAILBOX_USER "ep_mailbox_user_00"
> +#define XRT_MD_NODE_MAILBOX_XRT "ep_mailbox_user_to_ert_00"
> +#define XRT_MD_NODE_MSIX "ep_msix_00"
> +#define XRT_MD_NODE_P2P "ep_p2p_00"
> +#define XRT_MD_NODE_PCIE_MON "ep_pcie_link_mon_00"
> +#define XRT_MD_NODE_PMC_INTR   "ep_pmc_intr_00"
> +#define XRT_MD_NODE_PMC_MUX    "ep_pmc_mux_00"
> +#define XRT_MD_NODE_QDMA "ep_qdma_00"
> +#define XRT_MD_NODE_QDMA4 "ep_qdma4_00"
> +#define XRT_MD_NODE_REMAP_P2P "ep_remap_p2p_00"
> +#define XRT_MD_NODE_STM "ep_stream_traffic_manager_00"
> +#define XRT_MD_NODE_STM4 "ep_stream_traffic_manager4_00"
> +#define XRT_MD_NODE_SYSMON "ep_cmp_sysmon_00"
> +#define XRT_MD_NODE_XDMA "ep_xdma_00"
> +#define XRT_MD_NODE_XVC_PUB "ep_debug_bscan_user_00"
> +#define XRT_MD_NODE_XVC_PRI "ep_debug_bscan_mgmt_00"
> +#define XRT_MD_NODE_UCS_CONTROL_STATUS "ep_ucs_control_status_00"
> +
> +/* endpoint regmaps */
> +#define XRT_MD_REGMAP_DDR_SRSR "drv_ddr_srsr"
> +#define XRT_MD_REGMAP_CLKFREQ "freq_cnt"

clock frequency vs frequency count ?

is this ok?

> +
> +/* driver defined endpoints */
> +#define XRT_MD_NODE_BLP_ROM "drv_ep_blp_rom_00"
> +#define XRT_MD_NODE_DDR_SRSR "drv_ep_ddr_srsr"
> +#define XRT_MD_NODE_FLASH_VSEC "drv_ep_card_flash_program_00"
> +#define XRT_MD_NODE_GOLDEN_VER "drv_ep_golden_ver_00"
> +#define XRT_MD_NODE_MAILBOX_VSEC "drv_ep_mailbox_vsec_00"
> +#define XRT_MD_NODE_MGMT_MAIN "drv_ep_mgmt_main_00"
> +#define XRT_MD_NODE_PLAT_INFO "drv_ep_platform_info_mgmt_00"
> +#define XRT_MD_NODE_PARTITION_INFO_BLP "partition_info_0"
> +#define XRT_MD_NODE_PARTITION_INFO_PLP "partition_info_1"
> +#define XRT_MD_NODE_TEST "drv_ep_test_00"
> +#define XRT_MD_NODE_VSEC "drv_ep_vsec_00"
> +#define XRT_MD_NODE_VSEC_GOLDEN "drv_ep_vsec_golden_00"
> +
> +/* driver defined properties */
> +#define XRT_MD_PROP_OFFSET "drv_offset"
> +#define XRT_MD_PROP_CLK_FREQ "drv_clock_frequency"
> +#define XRT_MD_PROP_CLK_CNT "drv_clock_frequency_counter"
> +#define XRT_MD_PROP_VBNV "vbnv"
> +#define XRT_MD_PROP_VROM "vrom"
> +#define XRT_MD_PROP_PARTITION_LEVEL "partition_level"
> +
> +struct xrt_md_endpoint {
> +	const char	*ep_name;
> +	u32		bar;
> +	u64		bar_off;
> +	ulong		size;

bar_off changed from long to u64.

should bar and size both be changed to u64 ?

> +	char		*regmap;

It seems like this is really a compatibility string and not a regmap.

> +	char		*regmap_ver;
> +};
> +
> +/* Note: res_id is defined by leaf driver and must start with 0. */
> +struct xrt_iores_map {
> +	char		*res_name;
> +	int		res_id;
> +};
> +
> +static inline int xrt_md_res_name2id(const struct xrt_iores_map *res_map,
> +				     int entry_num, const char *res_name)
> +{
> +	int i;
> +
> +	for (i = 0; i < entry_num; i++) {
> +		if (!strncmp(res_name, res_map->res_name, strlen(res_map->res_name) + 1))
> +			return res_map->res_id;
> +		res_map++;
> +	}
> +	return -1;
> +}
> +
> +static inline const char *
> +xrt_md_res_id2name(const struct xrt_iores_map *res_map, int entry_num, int id)
> +{
> +	int i;
> +
> +	for (i = 0; i < entry_num; i++) {
> +		if (res_map->res_id == id)
> +			return res_map->res_name;
> +		res_map++;
> +	}
> +	return NULL;
> +}
> +
> +unsigned long xrt_md_size(struct device *dev, const char *blob);
> +int xrt_md_create(struct device *dev, char **blob);
> +char *xrt_md_dup(struct device *dev, const char *blob);
> +int xrt_md_add_endpoint(struct device *dev, char *blob,
> +			struct xrt_md_endpoint *ep);
> +int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
> +			const char *regmap_name);
> +int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
> +		    const char *regmap_name, const char *prop,
> +		    const void **val, int *size);
> +int xrt_md_set_prop(struct device *dev, char *blob, const char *ep_name,
> +		    const char *regmap_name, const char *prop,
> +		    const void *val, int size);
> +int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
> +			 const char *ep_name, const char *regmap_name,
> +			 const char *new_ep_name);
> +int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
> +			     const char *ep_name,  const char *regmap_name,
> +			     char **next_ep, char **next_regmap);
> +int xrt_md_get_compatible_endpoint(struct device *dev, const char *blob,
> +				   const char *regmap_name, const char **ep_name);
> +int xrt_md_find_endpoint(struct device *dev, const char *blob,
> +			 const char *ep_name, const char *regmap_name,
> +			 const char **epname);
> +int xrt_md_pack(struct device *dev, char *blob);
> +int xrt_md_get_interface_uuids(struct device *dev, const char *blob,
> +			       u32 num_uuids, uuid_t *intf_uuids);
> +
> +/*
> + * The firmware provides a 128 bit hash string as a unique id to the
> + * partition/interface.
> + * Existing hw does not yet use the cononical form, so it is necessary to
> + * use a translation function.
> + */
> +static inline void xrt_md_trans_uuid2str(const uuid_t *uuid, char *uuidstr)
> +{
> +	int i, p;
> +	u8 tmp[UUID_SIZE];
> +
> +	BUILD_BUG_ON(UUID_SIZE != 16);
> +	export_uuid(tmp, uuid);
ok
> +	for (p = 0, i = UUID_SIZE - 1; i >= 0; p++, i--)
> +		snprintf(&uuidstr[p * 2], 3, "%02x", tmp[i]);

XMGMT_UUID_STR_LEN is 80.

This logic say it could be reduced to 33.

> +}
> +
> +static inline int xrt_md_trans_str2uuid(struct device *dev, const char *uuidstr, uuid_t *p_uuid)
> +{
> +	u8 p[UUID_SIZE];
> +	const char *str;
> +	char tmp[3] = { 0 };
> +	int i, ret;
> +
> +	BUILD_BUG_ON(UUID_SIZE != 16);
Also defined above, do not need to repeat.
> +	str = uuidstr + strlen(uuidstr) - 2;
needs an underflow check
> +
> +	for (i = 0; i < sizeof(*p_uuid) && str >= uuidstr; i++) {
> +		tmp[0] = *str;
> +		tmp[1] = *(str + 1);
> +		ret = kstrtou8(tmp, 16, &p[i]);
> +		if (ret)
> +			return -EINVAL;
> +		str -= 2;
> +	}
> +	import_uuid(p_uuid, p);
> +
> +	return 0;
> +}
> +
> +#endif
> diff --git a/drivers/fpga/xrt/metadata/metadata.c b/drivers/fpga/xrt/metadata/metadata.c
> new file mode 100644
> index 000000000000..3b2be50fcb02
> --- /dev/null
> +++ b/drivers/fpga/xrt/metadata/metadata.c
> @@ -0,0 +1,545 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Metadata parse APIs
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *      Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#include <linux/libfdt_env.h>
> +#include "libfdt.h"
> +#include "metadata.h"
> +
> +#define MAX_BLOB_SIZE	(4096 * 25)
> +#define MAX_DEPTH 5

MAX_BLOB_SIZE is defined in keys/trusted-type.h

General, add a prefix to help avoid conflicts.

Like

XRT_MAX_BLOB_SIZE

etc.

> +
> +static int xrt_md_setprop(struct device *dev, char *blob, int offset,
> +			  const char *prop, const void *val, int size)
> +{
> +	int ret;
> +
> +	ret = fdt_setprop(blob, offset, prop, val, size);
> +	if (ret)
> +		dev_err(dev, "failed to set prop %d", ret);
> +
> +	return ret;
> +}
> +
> +static int xrt_md_add_node(struct device *dev, char *blob, int parent_offset,
> +			   const char *ep_name)
> +{
> +	int ret;
> +
> +	ret = fdt_add_subnode(blob, parent_offset, ep_name);
> +	if (ret < 0 && ret != -FDT_ERR_EXISTS)
> +		dev_err(dev, "failed to add node %s. %d", ep_name, ret);
> +
> +	return ret;
> +}
> +
> +static int xrt_md_get_endpoint(struct device *dev, const char *blob,
> +			       const char *ep_name, const char *regmap_name,
> +			       int *ep_offset)
> +{
> +	const char *name;
> +	int offset;
> +
> +	for (offset = fdt_next_node(blob, -1, NULL);
> +	    offset >= 0;
> +	    offset = fdt_next_node(blob, offset, NULL)) {
> +		name = fdt_get_name(blob, offset, NULL);
> +		if (!name || strncmp(name, ep_name, strlen(ep_name) + 1))
> +			continue;
> +		if (!regmap_name ||

regmap_name is known at the start but checked here in the loop.

this check should be made outside of the loop.

> +		    !fdt_node_check_compatible(blob, offset, regmap_name))
> +			break;
> +	}
> +	if (offset < 0)
> +		return -ENODEV;
> +
> +	*ep_offset = offset;
> +
> +	return 0;
> +}
> +
> +static inline int xrt_md_get_node(struct device *dev, const char *blob,
> +				  const char *name, const char *regmap_name,
> +				  int *offset)
> +{
> +	int ret = 0;
> +
> +	if (name) {
> +		ret = xrt_md_get_endpoint(dev, blob, name, regmap_name,
> +					  offset);
> +		if (ret) {
> +			dev_err(dev, "cannot get node %s, regmap %s, ret = %d",
> +				name, regmap_name, ret);
from above regmap_name is sometimes NULL.
> +			return -EINVAL;
> +		}
> +	} else {
> +		ret = fdt_next_node(blob, -1, NULL);
> +		if (ret < 0) {
> +			dev_err(dev, "internal error, ret = %d", ret);
> +			return -EINVAL;
> +		}
> +		*offset = ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xrt_md_overlay(struct device *dev, char *blob, int target,
> +			  const char *overlay_blob, int overlay_offset,
> +			  int depth)
> +{
> +	int	property, subnode;
> +	int	ret;

whitespace, looks like tab's after 'int'

should be consistent with space used elsewhere

> +
> +	if (!blob || !overlay_blob) {
> +		dev_err(dev, "blob is NULL");
> +		return -EINVAL;
> +	}
> +
> +	if (depth > MAX_DEPTH) {
ok
> +		dev_err(dev, "meta data depth beyond %d", MAX_DEPTH);
> +		return -EINVAL;
> +	}
> +
> +	if (target < 0) {
> +		target = fdt_next_node(blob, -1, NULL);
> +		if (target < 0) {
> +			dev_err(dev, "invalid target");
> +			return -EINVAL;
> +		}
> +	}
> +	if (overlay_offset < 0) {
> +		overlay_offset = fdt_next_node(overlay_blob, -1, NULL);
> +		if (overlay_offset < 0) {
> +			dev_err(dev, "invalid overlay");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	fdt_for_each_property_offset(property, overlay_blob, overlay_offset) {
> +		const char *name;
> +		const void *prop;
> +		int prop_len;
> +
> +		prop = fdt_getprop_by_offset(overlay_blob, property, &name,
> +					     &prop_len);
> +		if (!prop || prop_len >= MAX_BLOB_SIZE || prop_len < 0) {
> +			dev_err(dev, "internal error");
> +			return -EINVAL;
> +		}
> +
> +		ret = xrt_md_setprop(dev, blob, target, name, prop,
> +				     prop_len);
> +		if (ret) {
> +			dev_err(dev, "setprop failed, ret = %d", ret);
> +			return ret;
> +		}
> +	}
> +
> +	fdt_for_each_subnode(subnode, overlay_blob, overlay_offset) {
> +		const char *name = fdt_get_name(overlay_blob, subnode, NULL);
> +		int nnode;
> +
> +		nnode = xrt_md_add_node(dev, blob, target, name);
> +		if (nnode == -FDT_ERR_EXISTS)
> +			nnode = fdt_subnode_offset(blob, target, name);
> +		if (nnode < 0) {
> +			dev_err(dev, "add node failed, ret = %d", nnode);
> +			return nnode;

This is an offset, not an error code

return -EINVAL or similar

> +		}
> +
> +		ret = xrt_md_overlay(dev, blob, nnode, overlay_blob, subnode, depth + 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +unsigned long xrt_md_size(struct device *dev, const char *blob)
> +{

review fdt_ro_probe.

fdt_totalsize is signed 32 bit, this conversion to sometimes 64 bit is not necessary.

at most it should be uint32_t

> +	unsigned long len = (long)fdt_totalsize(blob);
> +
> +	if (len > MAX_BLOB_SIZE)
> +		return XRT_MD_INVALID_LENGTH;
> +
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_size);
> +
> +int xrt_md_create(struct device *dev, char **blob)
> +{
> +	int ret = 0;
> +
> +	if (!blob) {
> +		dev_err(dev, "blob is NULL");
> +		return -EINVAL;
> +	}
> +
> +	*blob = vzalloc(MAX_BLOB_SIZE);
> +	if (!*blob)
> +		return -ENOMEM;
> +
> +	ret = fdt_create_empty_tree(*blob, MAX_BLOB_SIZE);
> +	if (ret) {
> +		dev_err(dev, "format blob failed, ret = %d", ret);
> +		goto failed;
> +	}
> +
> +	ret = fdt_next_node(*blob, -1, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "No Node, ret = %d", ret);
> +		goto failed;
> +	}
> +
> +	ret = fdt_add_subnode(*blob, 0, XRT_MD_NODE_ENDPOINTS);
> +	if (ret < 0) {
fdt error code
> +		dev_err(dev, "add node failed, ret = %d", ret);
> +		goto failed;
> +	}
> +
> +	return 0;
> +
> +failed:
> +	vfree(*blob);
> +	*blob = NULL;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_create);
> +
> +char *xrt_md_dup(struct device *dev, const char *blob)
> +{
> +	char *dup_blob;
> +	int ret;
> +
> +	ret = xrt_md_create(dev, &dup_blob);
> +	if (ret)
> +		return NULL;
> +	ret = xrt_md_overlay(dev, dup_blob, -1, blob, -1, 0);
> +	if (ret) {
> +		vfree(dup_blob);
> +		return NULL;
> +	}
> +
> +	return dup_blob;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_dup);
Wasn't xrt_md_dup going to be replaced by memcpy ?
> +
> +int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
> +			const char *regmap_name)
> +{
> +	int ep_offset;
> +	int ret;
> +
> +	ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name, &ep_offset);
> +	if (ret) {
> +		dev_err(dev, "can not find ep %s", ep_name);
> +		return -EINVAL;
> +	}
> +
> +	ret = fdt_del_node(blob, ep_offset);

fdt return code

Fix these generally.

> +	if (ret)
> +		dev_err(dev, "delete node %s failed, ret %d", ep_name, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_del_endpoint);
> +
> +static int __xrt_md_add_endpoint(struct device *dev, char *blob,
> +				 struct xrt_md_endpoint *ep, int *offset,
> +				 const char *parent)
> +{
> +	int parent_offset = 0;
> +	u32 val, count = 0;
> +	int ep_offset = 0;
> +	u64 io_range[2];
> +	char comp[128];
> +	int ret = 0;
> +
> +	if (!ep->ep_name) {
> +		dev_err(dev, "empty name");
> +		return -EINVAL;
> +	}
> +
> +	if (parent) {
> +		ret = xrt_md_get_endpoint(dev, blob, parent, NULL, &parent_offset);
> +		if (ret) {
> +			dev_err(dev, "invalid blob, ret = %d", ret);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ep_offset = xrt_md_add_node(dev, blob, parent_offset, ep->ep_name);
> +	if (ep_offset < 0) {
> +		dev_err(dev, "add endpoint failed, ret = %d", ret);
> +		return -EINVAL;
> +	}
> +	if (offset)
> +		*offset = ep_offset;
> +
> +	if (ep->size != 0) {
> +		val = cpu_to_be32(ep->bar);
> +		ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_BAR_IDX,
> +				     &val, sizeof(u32));
> +		if (ret) {
> +			dev_err(dev, "set %s failed, ret %d",
> +				XRT_MD_PROP_BAR_IDX, ret);
> +			goto failed;
> +		}
> +		io_range[0] = cpu_to_be64((u64)ep->bar_off);
> +		io_range[1] = cpu_to_be64((u64)ep->size);
if ep->bar is an index, then rename the element to 'bar_index'
> +		ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_IO_OFFSET,
> +				     io_range, sizeof(io_range));
> +		if (ret) {
> +			dev_err(dev, "set %s failed, ret %d",
> +				XRT_MD_PROP_IO_OFFSET, ret);
> +			goto failed;
> +		}
> +	}
> +
> +	if (ep->regmap) {
> +		if (ep->regmap_ver) {
> +			count = snprintf(comp, sizeof(comp) - 1,
The -1 should be good enough that the if-check below is not needed
> +					 "%s-%s", ep->regmap, ep->regmap_ver);
> +			count++;
> +		}
> +		if (count > sizeof(comp)) {
> +			ret = -EINVAL;
> +			goto failed;
> +		}
> +
> +		count += snprintf(comp + count, sizeof(comp) - count - 1,
> +				  "%s", ep->regmap);
what happens when only part of regmap is added to comp ?
> +		count++;
> +		if (count > sizeof(comp)) {
> +			ret = -EINVAL;
> +			goto failed;
> +		}
> +
> +		ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_COMPATIBLE,
> +				     comp, count);
> +		if (ret) {
> +			dev_err(dev, "set %s failed, ret %d",
> +				XRT_MD_PROP_COMPATIBLE, ret);
> +			goto failed;
> +		}
> +	}
> +
> +failed:
> +	if (ret)
> +		xrt_md_del_endpoint(dev, blob, ep->ep_name, NULL);
> +
> +	return ret;
> +}
> +
> +int xrt_md_add_endpoint(struct device *dev, char *blob,
> +			struct xrt_md_endpoint *ep)
> +{
> +	return __xrt_md_add_endpoint(dev, blob, ep, NULL, XRT_MD_NODE_ENDPOINTS);
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_add_endpoint);
> +
> +int xrt_md_find_endpoint(struct device *dev, const char *blob,
> +			 const char *ep_name, const char *regmap_name,
> +			 const char **epname)
> +{
> +	int offset;
> +	int ret;
> +
> +	ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
> +				  &offset);
> +	if (!ret && epname)
split this condition, if the call failed, check and return early.
> +		*epname = fdt_get_name(blob, offset, NULL);
what happens if fdt_get_name fails ?
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_find_endpoint);
> +
> +int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
> +		    const char *regmap_name, const char *prop,
> +		    const void **val, int *size)
> +{
> +	int offset;
> +	int ret;
> +
> +	if (!val) {
> +		dev_err(dev, "val is null");
> +		return -EINVAL;
ok
> +	}
> +
> +	*val = NULL;
> +	ret = xrt_md_get_node(dev, blob, ep_name, regmap_name, &offset);
> +	if (ret)
> +		return ret;
> +
> +	*val = fdt_getprop(blob, offset, prop, size);
> +	if (!*val) {
> +		dev_dbg(dev, "get ep %s, prop %s failed", ep_name, prop);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_get_prop);
> +
> +int xrt_md_set_prop(struct device *dev, char *blob,
> +		    const char *ep_name, const char *regmap_name,
> +		    const char *prop, const void *val, int size)
> +{
> +	int offset;
> +	int ret;
> +
> +	ret = xrt_md_get_node(dev, blob, ep_name, regmap_name, &offset);
> +	if (ret)
> +		return ret;
> +
> +	ret = xrt_md_setprop(dev, blob, offset, prop, val, size);
ok
> +	if (ret)
> +		dev_err(dev, "set prop %s failed, ret = %d", prop, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_set_prop);
> +
> +int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
> +			 const char *ep_name, const char *regmap_name,
> +			 const char *new_ep_name)
> +{
> +	const char *newepnm = new_ep_name ? new_ep_name : ep_name;
> +	struct xrt_md_endpoint ep = {0};
> +	int offset, target;
> +	const char *parent;
> +	int ret;
> +
> +	ret = xrt_md_get_endpoint(dev, src_blob, ep_name, regmap_name,
> +				  &offset);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = xrt_md_get_endpoint(dev, blob, newepnm, regmap_name, &target);
> +	if (ret) {
> +		ep.ep_name = newepnm;
> +		parent = fdt_parent_offset(src_blob, offset) == 0 ? NULL : XRT_MD_NODE_ENDPOINTS;
> +		ret = __xrt_md_add_endpoint(dev, blob, &ep, &target, parent);
> +		if (ret)
> +			return -EINVAL;
> +	}
> +
> +	ret = xrt_md_overlay(dev, blob, target, src_blob, offset, 0);
> +	if (ret)
> +		dev_err(dev, "overlay failed, ret = %d", ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_copy_endpoint);
> +
> +int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
> +			     const char *ep_name, const char *regmap_name,
> +			     char **next_ep, char **next_regmap)
> +{
> +	int offset, ret;
> +
> +	*next_ep = NULL;
> +	*next_regmap = NULL;
> +	if (!ep_name) {
> +		ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_ENDPOINTS, NULL,
> +					  &offset);
> +	} else {
> +		ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
> +					  &offset);
> +	}
> +
> +	if (ret)
> +		return -EINVAL;
> +
> +	offset = ep_name ? fdt_next_subnode(blob, offset) :
> +		fdt_first_subnode(blob, offset);
tristate with function calls is harder to follow, convert this to if-else logic
> +	if (offset < 0)
> +		return -EINVAL;
> +
> +	*next_ep = (char *)fdt_get_name(blob, offset, NULL);
> +	*next_regmap = (char *)fdt_stringlist_get(blob, offset, XRT_MD_PROP_COMPATIBLE,
> +						  0, NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_get_next_endpoint);
> +
> +int xrt_md_get_compatible_endpoint(struct device *dev, const char *blob,
> +				   const char *regmap_name, const char **ep_name)
> +{
> +	int ep_offset;
> +
> +	ep_offset = fdt_node_offset_by_compatible(blob, -1, regmap_name);
> +	if (ep_offset < 0) {
> +		*ep_name = NULL;
> +		return -ENOENT;
> +	}
> +
> +	*ep_name = fdt_get_name(blob, ep_offset, NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_get_compatible_endpoint);
> +
> +int xrt_md_pack(struct device *dev, char *blob)
> +{
> +	int ret;
> +
> +	ret = fdt_pack(blob);
> +	if (ret)
> +		dev_err(dev, "pack failed %d", ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_pack);
> +
> +int xrt_md_get_interface_uuids(struct device *dev, const char *blob,
ok
> +			       u32 num_uuids, uuid_t *interface_uuids)
> +{
> +	int offset, count = 0;
> +	const char *uuid_str;
> +	int ret;
> +
> +	ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_INTERFACES, NULL, &offset);
> +	if (ret)
> +		return -ENOENT;
> +
> +	for (offset = fdt_first_subnode(blob, offset);
> +	    offset >= 0;
> +	    offset = fdt_next_subnode(blob, offset), count++) {
> +		uuid_str = fdt_getprop(blob, offset, XRT_MD_PROP_INTERFACE_UUID,
> +				       NULL);
> +		if (!uuid_str) {
> +			dev_err(dev, "empty interface uuid node");
> +			return -EINVAL;
> +		}
> +
> +		if (!num_uuids)
> +			continue;
> +
> +		if (count == num_uuids) {

ok

> +			dev_err(dev, "too many interface uuid in blob");
> +			return -EINVAL;
> +		}
> +
> +		if (interface_uuids && count < num_uuids) {
> +			ret = xrt_md_trans_str2uuid(dev, uuid_str,
> +						    &interface_uuids[count]);
> +			if (ret)
> +				return -EINVAL;
> +		}
> +	}
> +	if (!count)
> +		count = -ENOENT;
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_get_interface_uuids);

Thanks for the changes,

Tom

