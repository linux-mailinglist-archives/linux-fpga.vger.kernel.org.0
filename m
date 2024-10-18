Return-Path: <linux-fpga+bounces-785-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 157589A353B
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 08:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B421C20F93
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 06:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724B117DFEB;
	Fri, 18 Oct 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TC+zhIXH"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBAE15C144;
	Fri, 18 Oct 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232429; cv=none; b=MMGFPYDyty74/YUakT3S1RGQDK3Ia+R/ZUMhNLpT3NIy+aDTzEPaEIeL48pYrxJJhYrx7LFQyVUI2PLCRbodpAJ0SwKzofjm9wAuwecLV7pGtWm5QdQ8TDioJhI9Bsi5ZryzpIoQ8EVsXbpd7nUsYnMRoSO5+40hquk7mJLe+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232429; c=relaxed/simple;
	bh=DIXOVm6mGQY2NtZKQLGjI94/t9SRZMX0gCBs+9bAnlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzOKdNUJYnOkxPTsZKwbavaCuzhCTOuI9IV3dX2hTslxlBvGdevj3KLroAykjIwsujgtY9Usq9QDtmmiqpRJPq1lMI7Nba4bwaemPyJJpZyn1gNC0Zr/NTTdL+EJdd6b5IQUEvgTWxdbHSc0P0Nd4MribBnK3rw12R+7vLdcQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TC+zhIXH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729232427; x=1760768427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DIXOVm6mGQY2NtZKQLGjI94/t9SRZMX0gCBs+9bAnlw=;
  b=TC+zhIXHOLo7cIugnYKiNv1MNeHzBz881NGPMVkS6ZJREdulhxcartyX
   pIHf+nIPpJ1EmuhKfcEDg4aExVR0Zq1tsWlWdaIX7I/Ft0/fKrVg8r8aZ
   c66UZPGN5BR6apml0YcUi7Ul6BPtOBuXeYBnHA3cU3QY3x/uLFZc4KkYy
   djM/q7vmjlRe8G/q9D44uuDkgfreLCXVZ5vPEoNOfLBzQM3mNzAsUBBAL
   /8u46BbaW7NwwKmbiCoP+8iPAvEnKwxldfSwrxuKHyOEqPXobPoTG6Xxn
   fmvg9cmAt0nfAJLCVhjn05v6N6wxyOpZNZhFMTIjtmcUBrAaNaoOKXLZc
   w==;
X-CSE-ConnectionGUID: +DLizhGTT/WReAFaSL7ZYQ==
X-CSE-MsgGUID: w8ySqGG/QYSJIB7a9mzltw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28710707"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28710707"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:20:26 -0700
X-CSE-ConnectionGUID: lpo9/2hZRAq9i6C2lJzwsA==
X-CSE-MsgGUID: K6gYLvm/QReY1dqnRT41Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="79193744"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 17 Oct 2024 23:20:23 -0700
Date: Fri, 18 Oct 2024 14:17:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: David Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>
Subject: Re: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal
 PCIe card
Message-ID: <ZxH9Xjd0eU/7IDGC@yilunxu-OptiPlex-7050>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007220128.3023169-1-yidong.zhang@amd.com>

On Mon, Oct 07, 2024 at 03:01:26PM -0700, David Zhang wrote:
> From: Yidong Zhang <yidong.zhang@amd.com>
> 
> AMD Versal based PCIe card, including V70, is designed for AI inference
> efficiency and is tuned for video analytics and natural language processing
> applications.
> 
> Add the driver to support AMD Versal card management physical function.
> Only very basic functionalities are added.

I think this is not "basic" enough.  If possible please add your following
functionalities one by one.

>   - module and PCI device initialization
>   - fpga framework ops callbacks
>   - communication with user physical function

So IIUC this is a multifunction PCI device? Management PF & User PF?
Next time please add some description about the architecture overview
of this card, as well as how the SW stack is supposed to make the card
work.

> 
> Co-developed-by: DMG Karthik <Karthik.DMG@amd.com>
> Signed-off-by: DMG Karthik <Karthik.DMG@amd.com>
> Co-developed-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Co-developed-by: Prapul Krishnamurthy <prapulk@amd.com>
> Signed-off-by: Prapul Krishnamurthy <prapulk@amd.com>
> Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
> ---
>  MAINTAINERS                    |   7 +
>  drivers/fpga/Kconfig           |   3 +
>  drivers/fpga/Makefile          |   3 +
>  drivers/fpga/amd/Kconfig       |  17 ++
>  drivers/fpga/amd/Makefile      |   6 +
>  drivers/fpga/amd/vmgmt-comms.c | 344 ++++++++++++++++++++++++++++
>  drivers/fpga/amd/vmgmt-comms.h |  14 ++
>  drivers/fpga/amd/vmgmt.c       | 395 +++++++++++++++++++++++++++++++++
>  drivers/fpga/amd/vmgmt.h       | 100 +++++++++
>  include/uapi/linux/vmgmt.h     |  25 +++
>  10 files changed, 914 insertions(+)
>  create mode 100644 drivers/fpga/amd/Kconfig
>  create mode 100644 drivers/fpga/amd/Makefile
>  create mode 100644 drivers/fpga/amd/vmgmt-comms.c
>  create mode 100644 drivers/fpga/amd/vmgmt-comms.h
>  create mode 100644 drivers/fpga/amd/vmgmt.c
>  create mode 100644 drivers/fpga/amd/vmgmt.h
>  create mode 100644 include/uapi/linux/vmgmt.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a097afd76ded..645f00ccb342 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1185,6 +1185,13 @@ M:	Sanjay R Mehta <sanju.mehta@amd.com>
>  S:	Maintained
>  F:	drivers/spi/spi-amd.c
>  
> +AMD VERSAL PCI DRIVER
> +M:	Yidong Zhang <yidong.zhang@amd.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Supported
> +F:	drivers/fpga/amd/
> +F:	include/uapi/linux/vmgmt.h
> +
>  AMD XGBE DRIVER
>  M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 37b35f58f0df..dce060a7bd8f 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -290,4 +290,7 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
>  
>  source "drivers/fpga/tests/Kconfig"
>  
> +# Driver files
> +source "drivers/fpga/amd/Kconfig"
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index aeb89bb13517..5e8a3869f9a0 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -58,5 +58,8 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
>  
> +# AMD PCIe Versal Management Driver
> +obj-y					+= amd/
> +
>  # KUnit tests
>  obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
> diff --git a/drivers/fpga/amd/Kconfig b/drivers/fpga/amd/Kconfig
> new file mode 100644
> index 000000000000..126bc579a333
> --- /dev/null
> +++ b/drivers/fpga/amd/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config AMD_VERSAL_MGMT
> +	tristate "AMD PCIe Versal Management Driver"
> +	select FW_LOADER
> +	select FW_UPLOAD
> +	select REGMAP_MMIO
> +	depends on FPGA_BRIDGE
> +	depends on FPGA_REGION
> +	depends on HAS_IOMEM
> +	depends on PCI
> +	help
> +	  AMD PCIe Versal Management Driver provides management services to
> +	  download firmware, program bitstream, collect sensor data, control
> +	  resets, and communicate with the User function.
> +
> +	  If "M" is selected, the driver module will be amd-vmgmt.
> diff --git a/drivers/fpga/amd/Makefile b/drivers/fpga/amd/Makefile
> new file mode 100644
> index 000000000000..3e4c6dd3b787
> --- /dev/null
> +++ b/drivers/fpga/amd/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_AMD_VERSAL_MGMT)			+= amd-vmgmt.o

IMHO the naming vmgmt is hard to understand, any better idea?

> +
> +amd-vmgmt-$(CONFIG_AMD_VERSAL_MGMT)		:= vmgmt.o	\
> +						   vmgmt-comms.o
> diff --git a/drivers/fpga/amd/vmgmt-comms.c b/drivers/fpga/amd/vmgmt-comms.c
> new file mode 100644
> index 000000000000..bed0d369a744
> --- /dev/null
> +++ b/drivers/fpga/amd/vmgmt-comms.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Versal PCIe device
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/timer.h>
> +#include <linux/uuid.h>
> +#include <linux/workqueue.h>
> +
> +#include "vmgmt.h"
> +#include "vmgmt-comms.h"
> +
> +#define COMMS_PROTOCOL_VERSION			1
> +#define COMMS_PCI_BAR_OFF			0x2000000
> +#define COMMS_TIMER				(HZ / 10)
> +#define COMMS_DATA_LEN				16
> +#define COMMS_DATA_TYPE_MASK			GENMASK(7, 0)
> +#define COMMS_DATA_EOM_MASK			BIT(31)
> +#define COMMS_MSG_END				BIT(31)
> +
> +#define COMMS_REG_WRDATA_OFF			0x0
> +#define COMMS_REG_RDDATA_OFF			0x8
> +#define COMMS_REG_STATUS_OFF			0x10
> +#define COMMS_REG_ERROR_OFF			0x14
> +#define COMMS_REG_RIT_OFF			0x1C
> +#define COMMS_REG_IS_OFF			0x20
> +#define COMMS_REG_IE_OFF			0x24
> +#define COMMS_REG_CTRL_OFF			0x2C
> +#define COMMS_REGS_SIZE				0x1000
> +
> +#define COMMS_IRQ_DISABLE_ALL			0
> +#define COMMS_IRQ_RECEIVE_ENABLE		BIT(1)
> +#define COMMS_IRQ_CLEAR_ALL			GENMASK(2, 0)
> +#define COMMS_CLEAR_FIFO			GENMASK(1, 0)
> +#define COMMS_RECEIVE_THRESHOLD			15
> +
> +enum comms_req_ops {
> +	COMMS_REQ_OPS_UNKNOWN			= 0,
> +	COMMS_REQ_OPS_HOT_RESET			= 5,
> +	COMMS_REQ_OPS_GET_PROTOCOL_VERSION	= 19,
> +	COMMS_REQ_OPS_GET_XCLBIN_UUID		= 20,
> +	COMMS_REQ_OPS_MAX,
> +};
> +
> +enum comms_msg_type {
> +	COMMS_MSG_INVALID			= 0,
> +	COMMS_MSG_START				= 2,
> +	COMMS_MSG_BODY				= 3,
> +};
> +
> +enum comms_msg_service_type {
> +	COMMS_MSG_SRV_RESPONSE			= BIT(0),
> +	COMMS_MSG_SRV_REQUEST			= BIT(1),
> +};
> +
> +struct comms_hw_msg {
> +	struct {
> +		u32		type;
> +		u32		payload_size;
> +	} header;
> +	struct {
> +		u64		id;
> +		u32		flags;
> +		u32		size;
> +		u32		payload[COMMS_DATA_LEN - 6];
> +	} body;
> +} __packed;
> +
> +struct comms_srv_req {
> +	u64			flags;
> +	u32			opcode;
> +	u32			data[];
> +};
> +
> +struct comms_srv_ver_resp {
> +	u32			version;
> +};
> +
> +struct comms_srv_uuid_resp {
> +	uuid_t			uuid;
> +};
> +
> +struct comms_msg {
> +	u64			id;
> +	u32			flags;
> +	u32			len;
> +	u32			bytes_read;
> +	u32			data[10];
> +};
> +
> +struct comms_device {
> +	struct vmgmt_device	*vdev;
> +	struct regmap		*regmap;
> +	struct timer_list	timer;
> +	struct work_struct	work;
> +};
> +
> +static bool comms_regmap_rd_regs(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case COMMS_REG_RDDATA_OFF:
> +	case COMMS_REG_IS_OFF:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool comms_regmap_wr_regs(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case COMMS_REG_WRDATA_OFF:
> +	case COMMS_REG_IS_OFF:
> +	case COMMS_REG_IE_OFF:
> +	case COMMS_REG_CTRL_OFF:
> +	case COMMS_REG_RIT_OFF:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool comms_regmap_nir_regs(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case COMMS_REG_RDDATA_OFF:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config comms_regmap_config = {
> +	.name = "comms_config",
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.readable_reg = comms_regmap_rd_regs,
> +	.writeable_reg = comms_regmap_wr_regs,
> +	.readable_noinc_reg = comms_regmap_nir_regs,
> +};
> +
> +static inline struct comms_device *to_ccdev_work(struct work_struct *w)
> +{
> +	return container_of(w, struct comms_device, work);
> +}
> +
> +static inline struct comms_device *to_ccdev_timer(struct timer_list *t)
> +{
> +	return container_of(t, struct comms_device, timer);
> +}
> +
> +static u32 comms_set_uuid_resp(struct vmgmt_device *vdev, void *payload)
> +{
> +	struct comms_srv_uuid_resp *resp;
> +	u32 resp_len = sizeof(*resp);
> +
> +	resp = (struct comms_srv_uuid_resp *)payload;
> +	uuid_copy(&resp->uuid, &vdev->xclbin_uuid);
> +	vmgmt_dbg(vdev, "xclbin UUID: %pUb", &resp->uuid);
> +
> +	return resp_len;
> +}
> +
> +static u32 comms_set_protocol_resp(void *payload)
> +{
> +	struct comms_srv_ver_resp *resp = (struct comms_srv_ver_resp *)payload;
> +	u32 resp_len = sizeof(*resp);
> +
> +	resp->version = COMMS_PROTOCOL_VERSION;
> +
> +	return sizeof(resp_len);
> +}
> +
> +static void comms_send_response(struct comms_device *ccdev,
> +				struct comms_msg *msg)
> +{
> +	struct comms_srv_req *req = (struct comms_srv_req *)msg->data;
> +	struct vmgmt_device *vdev = ccdev->vdev;
> +	struct comms_hw_msg response = {0};
> +	u32 size;
> +	int ret;
> +	u8 i;
> +
> +	switch (req->opcode) {
> +	case COMMS_REQ_OPS_GET_PROTOCOL_VERSION:
> +		size = comms_set_protocol_resp(response.body.payload);
> +		break;
> +	case COMMS_REQ_OPS_GET_XCLBIN_UUID:
> +		size = comms_set_uuid_resp(vdev, response.body.payload);
> +		break;
> +	default:
> +		vmgmt_err(vdev, "Unsupported request opcode: %d", req->opcode);
> +		*response.body.payload = -1;
> +		size = sizeof(int);
> +	}
> +
> +	vmgmt_dbg(vdev, "Response opcode: %d", req->opcode);
> +
> +	response.header.type = COMMS_MSG_START | COMMS_MSG_END;
> +	response.header.payload_size = size;
> +
> +	response.body.flags = COMMS_MSG_SRV_RESPONSE;
> +	response.body.size = size;
> +	response.body.id = msg->id;
> +
> +	for (i = 0; i < COMMS_DATA_LEN; i++) {
> +		ret = regmap_write(ccdev->regmap, COMMS_REG_WRDATA_OFF, ((u32 *)&response)[i]);
> +		if (ret < 0) {
> +			vmgmt_err(vdev, "regmap write failed: %d", ret);
> +			return;
> +		}
> +	}
> +}
> +
> +#define STATUS_IS_READY(status) ((status) & BIT(1))
> +#define STATUS_IS_ERROR(status) ((status) & BIT(2))
> +
> +static void comms_check_request(struct work_struct *w)
> +{
> +	struct comms_device *ccdev = to_ccdev_work(w);
> +	u32 status = 0, request[COMMS_DATA_LEN] = {0};
> +	struct comms_hw_msg *hw_msg;
> +	struct comms_msg msg;
> +	u8 type, eom;
> +	int ret;
> +	int i;
> +
> +	ret = regmap_read(ccdev->regmap, COMMS_REG_IS_OFF, &status);
> +	if (ret) {
> +		vmgmt_err(ccdev->vdev, "regmap read failed: %d", ret);
> +		return;
> +	}
> +	if (!STATUS_IS_READY(status))
> +		return;
> +	if (STATUS_IS_ERROR(status)) {
> +		vmgmt_err(ccdev->vdev, "An error has occurred with comms");
> +		return;
> +	}
> +
> +	/* ACK status */
> +	regmap_write(ccdev->regmap, COMMS_REG_IS_OFF, status);
> +
> +	for (i = 0; i < COMMS_DATA_LEN; i++) {
> +		if (regmap_read(ccdev->regmap, COMMS_REG_RDDATA_OFF, &request[i]) < 0) {
> +			vmgmt_err(ccdev->vdev, "regmap read failed");
> +			return;
> +		}
> +	}
> +
> +	hw_msg = (struct comms_hw_msg *)request;
> +	type = FIELD_GET(COMMS_DATA_TYPE_MASK, hw_msg->header.type);
> +	eom = FIELD_GET(COMMS_DATA_EOM_MASK, hw_msg->header.type);
> +
> +	/* Only support fixed size 64B messages */
> +	if (!eom || type != COMMS_MSG_START) {
> +		vmgmt_err(ccdev->vdev, "Unsupported message format or length");
> +		return;
> +	}
> +
> +	msg.flags = hw_msg->body.flags;
> +	msg.len = hw_msg->body.size;
> +	msg.id = hw_msg->body.id;
> +
> +	if (msg.flags != COMMS_MSG_SRV_REQUEST) {
> +		vmgmt_err(ccdev->vdev, "Unsupported service request");
> +		return;
> +	}
> +
> +	if (hw_msg->body.size > sizeof(msg.data) * sizeof(msg.data[0])) {
> +		vmgmt_err(ccdev->vdev, "msg is too big: %d", hw_msg->body.size);
> +		return;
> +	}
> +	memcpy(msg.data, hw_msg->body.payload, hw_msg->body.size);

Why is the memcpy() necessary? I just see the data move from stack to
stack, finally they will be released all.

> +
> +	/* Now decode and respond appropriately */
> +	comms_send_response(ccdev, &msg);
> +}
> +
> +static void comms_sched_work(struct timer_list *t)
> +{
> +	struct comms_device *ccdev = to_ccdev_timer(t);
> +
> +	/* Schedule a work in the general workqueue */
> +	schedule_work(&ccdev->work);
> +	/* Periodic timer */
> +	mod_timer(&ccdev->timer, jiffies + COMMS_TIMER);
> +}
> +
> +static void comms_config(struct comms_device *ccdev)
> +{
> +	/* Disable interrupts */
> +	regmap_write(ccdev->regmap, COMMS_REG_IE_OFF, COMMS_IRQ_DISABLE_ALL);
> +	/* Clear request and response FIFOs */
> +	regmap_write(ccdev->regmap, COMMS_REG_CTRL_OFF, COMMS_CLEAR_FIFO);
> +	/* Clear interrupts */
> +	regmap_write(ccdev->regmap, COMMS_REG_IS_OFF, COMMS_IRQ_CLEAR_ALL);
> +	/* Setup RIT reg */
> +	regmap_write(ccdev->regmap, COMMS_REG_RIT_OFF, COMMS_RECEIVE_THRESHOLD);
> +	/* Enable RIT interrupt */
> +	regmap_write(ccdev->regmap, COMMS_REG_IE_OFF, COMMS_IRQ_RECEIVE_ENABLE);
> +
> +	/* Create and schedule timer to do recurring work */
> +	INIT_WORK(&ccdev->work, &comms_check_request);
> +	timer_setup(&ccdev->timer, &comms_sched_work, 0);
> +	mod_timer(&ccdev->timer, jiffies + COMMS_TIMER);

Do we have to use raw timer+workqueue for a normal periodic task? Could
delayed_work work for you?

And do we have to do endless periodic query? Couldn't the user PF driver
trigger the service? Where is the user PF driver?

> +}
> +
> +void vmgmtm_comms_fini(struct comms_device *ccdev)
> +{
> +	/* First stop scheduling new work then cancel work */
> +	del_timer_sync(&ccdev->timer);
> +	cancel_work_sync(&ccdev->work);
> +}
> +
> +struct comms_device *vmgmtm_comms_init(struct vmgmt_device *vdev)

So 'comms' means 'communication with user PF ', is it? I thought it was
some common services at first, especially it is introduced in the first
basic patch.

Any better name?

> +{
> +	struct comms_device *ccdev;
> +
> +	ccdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*ccdev), GFP_KERNEL);
> +	if (!ccdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ccdev->vdev = vdev;
> +
> +	ccdev->regmap = devm_regmap_init_mmio(&vdev->pdev->dev,
> +					      vdev->tbl + COMMS_PCI_BAR_OFF,
> +					      &comms_regmap_config);

I'm not sure why a regmap is needed. All register accessing is within
the same module/file, and I assume a base+offset is enough to position
the register addr.

> +	if (IS_ERR(ccdev->regmap)) {
> +		vmgmt_err(vdev, "Comms regmap init failed");
> +		return ERR_CAST(ccdev->regmap);
> +	}
> +
> +	comms_config(ccdev);
> +	return ccdev;
> +}
> diff --git a/drivers/fpga/amd/vmgmt-comms.h b/drivers/fpga/amd/vmgmt-comms.h
> new file mode 100644
> index 000000000000..0afb14c8bd32
> --- /dev/null
> +++ b/drivers/fpga/amd/vmgmt-comms.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Driver for Versal PCIe device
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __VMGMT_COMMS_H
> +#define __VMGMT_COMMS_H
> +
> +struct comms_device *vmgmtm_comms_init(struct vmgmt_device *vdev);
> +void vmgmtm_comms_fini(struct comms_device *ccdev);
> +
> +#endif	/* __VMGMT_COMMS_H */
> diff --git a/drivers/fpga/amd/vmgmt.c b/drivers/fpga/amd/vmgmt.c
> new file mode 100644
> index 000000000000..b72eff9e8bc0
> --- /dev/null
> +++ b/drivers/fpga/amd/vmgmt.c
> @@ -0,0 +1,395 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Versal PCIe device
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/device/class.h>
> +#include <linux/err.h>
> +#include <linux/firmware.h>
> +#include <linux/fs.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/idr.h>
> +#include <linux/kdev_t.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
> +#include <linux/vmgmt.h>
> +
> +#include "vmgmt.h"
> +#include "vmgmt-comms.h"
> +
> +#define DRV_NAME			"amd-vmgmt"
> +#define CLASS_NAME			DRV_NAME
> +
> +#define PCI_DEVICE_ID_V70PQ2		0x50B0
> +#define VERSAL_XCLBIN_MAGIC_ID		"xclbin2"
> +
> +static DEFINE_IDA(vmgmt_dev_minor_ida);
> +static dev_t vmgmt_devnode;
> +struct class *vmgmt_class;
> +static struct fpga_bridge_ops vmgmt_br_ops;
> +
> +struct vmgmt_fpga_region {
> +	struct fpga_device *fdev;
> +	uuid_t *uuid;
> +};
> +
> +static inline struct vmgmt_device *vmgmt_inode_to_vdev(struct inode *inode)
> +{
> +	return (struct vmgmt_device *)container_of(inode->i_cdev, struct vmgmt_device, cdev);
> +}
> +
> +static enum fpga_mgr_states vmgmt_fpga_state(struct fpga_manager *mgr)
> +{
> +	struct fpga_device *fdev = mgr->priv;
> +
> +	return fdev->state;
> +}
> +
> +static const struct fpga_manager_ops vmgmt_fpga_ops = {
> +	.state = vmgmt_fpga_state,

If you want to add a skeleton, then add all skeleton ops with no
implementation. This makes me think the fpga_manager need .state() only.

> +};
> +
> +static int vmgmt_get_bridges(struct fpga_region *region)
> +{
> +	struct fpga_device *fdev = region->priv;
> +
> +	return fpga_bridge_get_to_list(&fdev->vdev->pdev->dev, region->info,
> +				       &region->bridge_list);
> +}
> +
> +static void vmgmt_fpga_fini(struct fpga_device *fdev)
> +{
> +	fpga_region_unregister(fdev->region);
> +	fpga_bridge_unregister(fdev->bridge);
> +	fpga_mgr_unregister(fdev->mgr);
> +}
> +
> +static struct fpga_device *vmgmt_fpga_init(struct vmgmt_device *vdev)
> +{
> +	struct device *dev = &vdev->pdev->dev;
> +	struct fpga_region_info region = { 0 };
> +	struct fpga_manager_info info = { 0 };
> +	struct fpga_device *fdev;
> +	int ret;
> +
> +	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
> +	if (!fdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fdev->vdev = vdev;
> +
> +	info = (struct fpga_manager_info) {
> +		.name = "AMD Versal FPGA Manager",
> +		.mops = &vmgmt_fpga_ops,
> +		.priv = fdev,
> +	};
> +
> +	fdev->mgr = fpga_mgr_register_full(dev, &info);
> +	if (IS_ERR(fdev->mgr)) {
> +		ret = PTR_ERR(fdev->mgr);
> +		vmgmt_err(vdev, "Failed to register FPGA manager, err %d", ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* create fgpa bridge, region for the base shell */
> +	fdev->bridge = fpga_bridge_register(dev, "AMD Versal FPGA Bridge",
> +					    &vmgmt_br_ops, fdev);

I didn't find the br_ops anywhere in this patchset. So how to gate the
FPGA region when it is being reprogrammed? What is the physical link
between the FPGA region and outside visitors?

> +	if (IS_ERR(fdev->bridge)) {
> +		vmgmt_err(vdev, "Failed to register FPGA bridge, err %ld",
> +			  PTR_ERR(fdev->bridge));
> +		ret = PTR_ERR(fdev->bridge);
> +		goto unregister_fpga_mgr;
> +	}
> +
> +	region = (struct fpga_region_info) {
> +		.compat_id = (struct fpga_compat_id *)&vdev->intf_uuid,
> +		.get_bridges = vmgmt_get_bridges,
> +		.mgr = fdev->mgr,
> +		.priv = fdev,
> +	};
> +
> +	fdev->region = fpga_region_register_full(dev, &region);

I assume the fpga region represents the user PF, is it? If you
reprogram the FPGA region, how does the user PF driver aware the HW is
changing?

> +	if (IS_ERR(fdev->region)) {
> +		vmgmt_err(vdev, "Failed to register FPGA region, err %ld",
> +			  PTR_ERR(fdev->region));
> +		ret = PTR_ERR(fdev->region);
> +		goto unregister_fpga_bridge;
> +	}
> +
> +	return fdev;
> +
> +unregister_fpga_bridge:
> +	fpga_bridge_unregister(fdev->bridge);
> +
> +unregister_fpga_mgr:
> +	fpga_mgr_unregister(fdev->mgr);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +static int vmgmt_open(struct inode *inode, struct file *filep)
> +{
> +	struct vmgmt_device *vdev = vmgmt_inode_to_vdev(inode);
> +
> +	if (WARN_ON(!vdev))
> +		return -ENODEV;
> +
> +	filep->private_data = vdev;
> +
> +	return 0;
> +}
> +
> +static int vmgmt_release(struct inode *inode, struct file *filep)
> +{
> +	filep->private_data = NULL;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations vmgmt_fops = {
> +	.owner = THIS_MODULE,
> +	.open = vmgmt_open,
> +	.release = vmgmt_release,
> +};
> +
> +static void vmgmt_chrdev_destroy(struct vmgmt_device *vdev)
> +{
> +	device_destroy(vmgmt_class, vdev->cdev.dev);
> +	cdev_del(&vdev->cdev);
> +	ida_free(&vmgmt_dev_minor_ida, vdev->minor);
> +}
> +
> +static int vmgmt_chrdev_create(struct vmgmt_device *vdev)
> +{
> +	u32 devid;
> +	int ret;
> +
> +	vdev->minor = ida_alloc(&vmgmt_dev_minor_ida, GFP_KERNEL);
> +	if (vdev->minor < 0) {
> +		vmgmt_err(vdev, "Failed to allocate chrdev ID");
> +		return -ENODEV;
> +	}
> +
> +	cdev_init(&vdev->cdev, &vmgmt_fops);
> +
> +	vdev->cdev.owner = THIS_MODULE;
> +	vdev->cdev.dev = MKDEV(MAJOR(vmgmt_devnode), vdev->minor);
> +	ret = cdev_add(&vdev->cdev, vdev->cdev.dev, 1);
> +	if (ret) {
> +		vmgmt_err(vdev, "Failed to add char device: %d\n", ret);
> +		ida_free(&vmgmt_dev_minor_ida, vdev->minor);
> +		return -ENODEV;
> +	}
> +
> +	devid = PCI_DEVID(vdev->pdev->bus->number, vdev->pdev->devfn);
> +	vdev->device = device_create(vmgmt_class, &vdev->pdev->dev,
> +				     vdev->cdev.dev, NULL, "%s%x", DRV_NAME,
> +				     devid);
> +	if (IS_ERR(vdev->device)) {
> +		vmgmt_err(vdev, "Failed to create device: %ld\n",
> +			  PTR_ERR(vdev->device));
> +		cdev_del(&vdev->cdev);
> +		ida_free(&vmgmt_dev_minor_ida, vdev->minor);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void vmgmt_fw_cancel(struct fw_upload *fw_upload)
> +{
> +	struct firmware_device *fwdev = fw_upload->dd_handle;
> +
> +	vmgmt_warn(fwdev->vdev, "canceled");
> +}
> +
> +static const struct fw_upload_ops vmgmt_fw_ops = {
> +	.cancel = vmgmt_fw_cancel,

Same concern.

> +};
> +
> +static void vmgmt_fw_upload_fini(struct firmware_device *fwdev)
> +{
> +	firmware_upload_unregister(fwdev->fw);
> +	kfree(fwdev->name);
> +}
> +
> +static struct firmware_device *vmgmt_fw_upload_init(struct vmgmt_device *vdev)
> +{
> +	struct device *dev = &vdev->pdev->dev;
> +	struct firmware_device *fwdev;
> +	u32 devid;
> +
> +	fwdev = devm_kzalloc(dev, sizeof(*fwdev), GFP_KERNEL);
> +	if (!fwdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	devid = PCI_DEVID(vdev->pdev->bus->number, vdev->pdev->devfn);
> +	fwdev->name = kasprintf(GFP_KERNEL, "%s%x", DRV_NAME, devid);
> +	if (!fwdev->name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fwdev->fw = firmware_upload_register(THIS_MODULE, dev, fwdev->name,
> +					     &vmgmt_fw_ops, fwdev);
> +	if (IS_ERR(fwdev->fw)) {
> +		kfree(fwdev->name);
> +		return ERR_CAST(fwdev->fw);
> +	}
> +
> +	fwdev->vdev = vdev;
> +
> +	return fwdev;
> +}
> +
> +static void vmgmt_device_teardown(struct vmgmt_device *vdev)
> +{
> +	vmgmt_fpga_fini(vdev->fdev);
> +	vmgmt_fw_upload_fini(vdev->fwdev);
> +	vmgmtm_comms_fini(vdev->ccdev);
> +}
> +
> +static int vmgmt_device_setup(struct vmgmt_device *vdev)
> +{
> +	int ret;
> +
> +	vdev->fwdev = vmgmt_fw_upload_init(vdev);
> +	if (IS_ERR(vdev->fwdev)) {
> +		ret = PTR_ERR(vdev->fwdev);
> +		vmgmt_err(vdev, "Failed to init FW uploader, err %d", ret);
> +		goto done;
> +	}
> +
> +	vdev->ccdev = vmgmtm_comms_init(vdev);
> +	if (IS_ERR(vdev->ccdev)) {
> +		ret = PTR_ERR(vdev->ccdev);
> +		vmgmt_err(vdev, "Failed to init comms channel, err %d", ret);
> +		goto upload_fini;
> +	}
> +
> +	vdev->fdev = vmgmt_fpga_init(vdev);
> +	if (IS_ERR(vdev->fdev)) {
> +		ret = PTR_ERR(vdev->fdev);
> +		vmgmt_err(vdev, "Failed to init FPGA maanger, err %d", ret);
> +		goto comms_fini;
> +	}
> +
> +	return 0;
> +comms_fini:
> +	vmgmtm_comms_fini(vdev->ccdev);
> +upload_fini:
> +	vmgmt_fw_upload_fini(vdev->fwdev);
> +done:
> +	return ret;
> +}
> +
> +static void vmgmt_remove(struct pci_dev *pdev)
> +{
> +	struct vmgmt_device *vdev = pci_get_drvdata(pdev);
> +
> +	vmgmt_chrdev_destroy(vdev);
> +	vmgmt_device_teardown(vdev);
> +}
> +
> +static int vmgmt_probe(struct pci_dev *pdev,
> +		       const struct pci_device_id *pdev_id)
> +{
> +	struct vmgmt_device *vdev;
> +	int ret;
> +
> +	vdev = devm_kzalloc(&pdev->dev, sizeof(*vdev), GFP_KERNEL);
> +	if (!vdev)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, vdev);
> +	vdev->pdev = pdev;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		vmgmt_err(vdev, "Failed to enable device %d", ret);
> +		return ret;
> +	}
> +
> +	ret = pcim_iomap_regions(vdev->pdev, AMD_VMGMT_BAR_MASK, "amd-vmgmt");
> +	if (ret) {
> +		vmgmt_err(vdev, "Failed iomap regions %d", ret);
> +		return -ENOMEM;
> +	}
> +
> +	vdev->tbl = pcim_iomap_table(vdev->pdev)[AMD_VMGMT_BAR];
> +	if (IS_ERR(vdev->tbl)) {
> +		vmgmt_err(vdev, "Failed to map RM shared memory BAR%d", AMD_VMGMT_BAR);
> +		return -ENOMEM;
> +	}

Deprecating pcim_iomap_regions & pcim_iomap_table is WIP. FYI.

  https://lore.kernel.org/all/20241016094911.24818-5-pstanner@redhat.com/

> +
> +	ret = vmgmt_device_setup(vdev);
> +	if (ret) {
> +		vmgmt_err(vdev, "Failed to setup Versal device %d", ret);
> +		return ret;
> +	}
> +
> +	ret = vmgmt_chrdev_create(vdev);
> +	if (ret) {
> +		vmgmt_device_teardown(vdev);
> +		return ret;
> +	}
> +
> +	vmgmt_dbg(vdev, "Successfully probed %s driver!", DRV_NAME);
> +	return 0;
> +}
> +
> +static const struct pci_device_id vmgmt_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_V70PQ2), },
> +	{ 0 }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, vmgmt_pci_ids);
> +
> +static struct pci_driver amd_vmgmt_driver = {
> +	.name = DRV_NAME,
> +	.id_table = vmgmt_pci_ids,
> +	.probe = vmgmt_probe,
> +	.remove = vmgmt_remove,
> +};
> +
> +static int amd_vmgmt_init(void)
> +{
> +	int ret;
> +
> +	vmgmt_class = class_create(CLASS_NAME);
> +	if (IS_ERR(vmgmt_class))
> +		return PTR_ERR(vmgmt_class);
> +
> +	ret = alloc_chrdev_region(&vmgmt_devnode, 0, MINORMASK, DRV_NAME);
> +	if (ret)
> +		goto chr_err;
> +
> +	ret = pci_register_driver(&amd_vmgmt_driver);
> +	if (ret)
> +		goto pci_err;
> +
> +	return 0;
> +
> +pci_err:
> +	unregister_chrdev_region(vmgmt_devnode, MINORMASK);
> +chr_err:
> +	class_destroy(vmgmt_class);
> +	return ret;
> +}
> +
> +static void amd_vmgmt_exit(void)
> +{
> +	pci_unregister_driver(&amd_vmgmt_driver);
> +	unregister_chrdev_region(vmgmt_devnode, MINORMASK);
> +	class_destroy(vmgmt_class);
> +}
> +
> +module_init(amd_vmgmt_init);
> +module_exit(amd_vmgmt_exit);
> +
> +MODULE_DESCRIPTION("AMD PCIe Versal Management Driver");
> +MODULE_AUTHOR("XRT Team <runtimeca39d@amd.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/fpga/amd/vmgmt.h b/drivers/fpga/amd/vmgmt.h
> new file mode 100644
> index 000000000000..4dc8a43f825e
> --- /dev/null
> +++ b/drivers/fpga/amd/vmgmt.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Driver for Versal PCIe device
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __VMGMT_H
> +#define __VMGMT_H
> +
> +#include <linux/cdev.h>
> +#include <linux/dev_printk.h>
> +#include <linux/jiffies.h>
> +#include <linux/list.h>
> +#include <linux/firmware.h>
> +#include <linux/fpga/fpga-bridge.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-region.h>
> +#include <linux/pci.h>
> +#include <linux/uuid.h>
> +#include <linux/regmap.h>
> +
> +#define AMD_VMGMT_BAR			0
> +#define AMD_VMGMT_BAR_MASK		BIT(0)
> +
> +#define vmgmt_info(vdev, fmt, args...)					\
> +	dev_info(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
> +
> +#define vmgmt_warn(vdev, fmt, args...)					\
> +	dev_warn(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
> +
> +#define vmgmt_err(vdev, fmt, args...)					\
> +	dev_err(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
> +
> +#define vmgmt_dbg(vdev, fmt, args...)					\
> +	dev_dbg(&(vdev)->pdev->dev, fmt, ##args)
> +
> +struct vmgmt_device;
> +struct comms_device;
> +struct rm_cmd;
> +
> +struct axlf_header {
> +	u64				length;
> +	unsigned char			reserved1[24];
> +	uuid_t				rom_uuid;
> +	unsigned char			reserved2[64];
> +	uuid_t				uuid;
> +	unsigned char			reserved3[24];
> +} __packed;
> +
> +struct axlf {
> +	char				magic[8];
> +	unsigned char			reserved[296];
> +	struct axlf_header		header;
> +} __packed;
> +
> +struct fw_tnx {
> +	struct rm_cmd		*cmd;
> +	int			opcode;
> +	int			id;
> +};
> +
> +struct fpga_device {
> +	enum fpga_mgr_states	state;
> +	struct fpga_manager	*mgr;
> +	struct fpga_bridge	*bridge;
> +	struct fpga_region	*region;
> +	struct vmgmt_device	*vdev;
> +	struct fw_tnx		fw;
> +};
> +
> +struct firmware_device {
> +	struct vmgmt_device	*vdev;
> +	struct fw_upload	*fw;
> +	char			*name;
> +	u32			fw_name_id;
> +	struct rm_cmd		*cmd;
> +	int			id;
> +	uuid_t			uuid;
> +};
> +
> +struct vmgmt_device {
> +	struct pci_dev		*pdev;
> +
> +	struct rm_device	*rdev;
> +	struct comms_device	*ccdev;
> +	struct fpga_device	*fdev;
> +	struct firmware_device	*fwdev;
> +	struct cdev		cdev;
> +	struct device		*device;
> +
> +	int                     minor;
> +	void __iomem		*tbl;
> +	uuid_t			xclbin_uuid;
> +	uuid_t			intf_uuid;
> +
> +	void                    *debugfs_root;
> +};
> +
> +#endif	/* __VMGMT_H */
> diff --git a/include/uapi/linux/vmgmt.h b/include/uapi/linux/vmgmt.h
> new file mode 100644
> index 000000000000..2269ceb5c131
> --- /dev/null
> +++ b/include/uapi/linux/vmgmt.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Header file for Versal PCIe device user API
> + *
> + * Copyright (C) 2024 AMD Corporation, Inc.
> + */
> +
> +#ifndef _UAPI_LINUX_VMGMT_H
> +#define _UAPI_LINUX_VMGMT_H
> +
> +#include <linux/ioctl.h>
> +
> +#define VERSAL_MGMT_MAGIC	0xB7
> +#define VERSAL_MGMT_BASE	0
> +
> +/**
> + * VERSAL_MGMT_LOAD_XCLBIN_IOCTL - Download XCLBIN to the device
> + *
> + * This IOCTL is used to download XCLBIN down to the device.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define VERSAL_MGMT_LOAD_XCLBIN_IOCTL	_IOW(VERSAL_MGMT_MAGIC,		\
> +					     VERSAL_MGMT_BASE + 0, void *)

Many definitions are added in a batch but some are not used in this
patch. Please reorganize the patches for easer review, even for first
version.

Thanks,
Yilun

> +
> +#endif /* _UAPI_LINUX_VMGMT_H */
> -- 
> 2.34.1
> 
> 

