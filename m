Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0C326696
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Feb 2021 18:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBZR5f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Feb 2021 12:57:35 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33199 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZR5e (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Feb 2021 12:57:34 -0500
Received: by mail-pl1-f179.google.com with SMTP id b8so2879694plh.0;
        Fri, 26 Feb 2021 09:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bgPYSxbnRboRk5YHmaFEvghKVAMuL118KqdRiljlQTE=;
        b=WBo78sOoie9wUTBjJJn7AJ6/inIvQOTWuHpmy/DUG42vskBTJ+R6hnXo7bSMFtzSua
         B8FTWqhd0nKGpF2zq0Jz+Jto1qOLVayzelsEycpEsrAB+cGI56qb+GXvAFd2OlaXPHsS
         Z3Hf1HV9r8aGDPFSgl7DgPvyiOeg8qSkxlrb6nCma+OqGzp0LQG73zHit2MwcJx+CSGo
         VEch0TRL670PuXgpMvxSYEMptYUG9Qx96fgfbZ01MhIXjjsKxGTK/xKHJ3izfk0I7bgM
         UXSeNSRlsyFx0eWQ/wdaCXNpR63q5sHO8icnvB6HiaAP/FcOsyIbdtD9XRz44CLRaXQ4
         ab+A==
X-Gm-Message-State: AOAM5322twAj5RWyJcGMldCxO1xDo04N5ZGdQLFWzN+obcoU0YT4zjZX
        r9uZcGJyvMcY+DVnSWk5FDQ=
X-Google-Smtp-Source: ABdhPJwzcEtYkKHrj77m2Z/GdAJNYNZODfrP6KiZGTelMsUdA9AnqzyGXVh3zKbdaLGf/rzUQES24w==
X-Received: by 2002:a17:90b:364e:: with SMTP id nh14mr4589800pjb.115.1614362212715;
        Fri, 26 Feb 2021 09:56:52 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id z13sm11013012pfk.178.2021.02.26.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:56:51 -0800 (PST)
Date:   Fri, 26 Feb 2021 09:56:49 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        "mdf@kernel.org" <mdf@kernel.org>, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, robh@kernel.org,
        Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V3 XRT Alveo 07/18] fpga: xrt: management physical
 function driver (root)
Message-ID: <YDk2YT0otybb1+Sg@archbook>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-8-lizhih@xilinx.com>
 <d0057bee-2cf1-b560-c160-636d8e76cbda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0057bee-2cf1-b560-c160-636d8e76cbda@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Feb 26, 2021 at 07:01:05AM -0800, Tom Rix wrote:
> A question i do not know the answer to.
> 
> Seems like 'golden' is linked to a manufacturing (diagnostics?) image.

From my brief history with Xilinx Ultrascale+ PCI cards I recall the golden
image being a sort of known good recovery image.

If we can't tell it should probably be explained better :)
> 
> If the public will never see it, should handling it here be done ?

Yes. We do want people to run their entire stack using mainline linux,
not just a part of it, if code is needed to get from recovery image to
full image or similar, then we should support that.

> Moritz, do you know ?
> 
> 
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
> > The PCIE device driver which attaches to management function on Alveo
> to the management
> > devices. It instantiates one or more partition drivers which in turn
> more fpga partition / group ?
> > instantiate platform drivers. The instantiation of partition and platform
> > drivers is completely data driven.
> data driven ? everything is data driven.  do you mean dtb driven ?
> >
> > Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> > Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> > Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> > ---
> >  drivers/fpga/xrt/include/xroot.h | 114 +++++++++++
> >  drivers/fpga/xrt/mgmt/root.c     | 342 +++++++++++++++++++++++++++++++
> >  2 files changed, 456 insertions(+)
> >  create mode 100644 drivers/fpga/xrt/include/xroot.h
> >  create mode 100644 drivers/fpga/xrt/mgmt/root.c
> >
> > diff --git a/drivers/fpga/xrt/include/xroot.h b/drivers/fpga/xrt/include/xroot.h
> > new file mode 100644
> > index 000000000000..752e10daa85e
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/include/xroot.h
> > @@ -0,0 +1,114 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Header file for Xilinx Runtime (XRT) driver
> > + *
> > + * Copyright (C) 2020-2021 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *	Cheng Zhen <maxz@xilinx.com>
> > + */
> > +
> > +#ifndef _XRT_ROOT_H_
> > +#define _XRT_ROOT_H_
> > +
> > +#include <linux/pci.h>
> > +#include "subdev_id.h"
> > +#include "events.h"
> > +
> > +typedef bool (*xrt_subdev_match_t)(enum xrt_subdev_id,
> > +	struct platform_device *, void *);
> > +#define XRT_SUBDEV_MATCH_PREV	((xrt_subdev_match_t)-1)
> > +#define XRT_SUBDEV_MATCH_NEXT	((xrt_subdev_match_t)-2)
> > +
> > +/*
> > + * Root IOCTL calls.
> > + */
> > +enum xrt_root_ioctl_cmd {
> > +	/* Leaf actions. */
> > +	XRT_ROOT_GET_LEAF = 0,
> > +	XRT_ROOT_PUT_LEAF,
> > +	XRT_ROOT_GET_LEAF_HOLDERS,
> > +
> > +	/* Group actions. */
> > +	XRT_ROOT_CREATE_GROUP,
> > +	XRT_ROOT_REMOVE_GROUP,
> > +	XRT_ROOT_LOOKUP_GROUP,
> > +	XRT_ROOT_WAIT_GROUP_BRINGUP,
> > +
> > +	/* Event actions. */
> > +	XRT_ROOT_EVENT,
> should this be XRT_ROOT_EVENT_SYNC ?
> > +	XRT_ROOT_EVENT_ASYNC,
> > +
> > +	/* Device info. */
> > +	XRT_ROOT_GET_RESOURCE,
> > +	XRT_ROOT_GET_ID,
> > +
> > +	/* Misc. */
> > +	XRT_ROOT_HOT_RESET,
> > +	XRT_ROOT_HWMON,
> > +};
> > +
> > +struct xrt_root_ioctl_get_leaf {
> > +	struct platform_device *xpigl_pdev; /* caller's pdev */
> xpigl_ ? unneeded suffix in element names
> > +	xrt_subdev_match_t xpigl_match_cb;
> > +	void *xpigl_match_arg;
> > +	struct platform_device *xpigl_leaf; /* target leaf pdev */
> > +};
> > +
> > +struct xrt_root_ioctl_put_leaf {
> > +	struct platform_device *xpipl_pdev; /* caller's pdev */
> > +	struct platform_device *xpipl_leaf; /* target's pdev */
> 
> caller_pdev;
> 
> target_pdev;
> 
> > +};
> > +
> > +struct xrt_root_ioctl_lookup_group {
> > +	struct platform_device *xpilp_pdev; /* caller's pdev */
> > +	xrt_subdev_match_t xpilp_match_cb;
> > +	void *xpilp_match_arg;
> > +	int xpilp_grp_inst;
> > +};
> > +
> > +struct xrt_root_ioctl_get_holders {
> > +	struct platform_device *xpigh_pdev; /* caller's pdev */
> > +	char *xpigh_holder_buf;
> > +	size_t xpigh_holder_buf_len;
> > +};
> > +
> > +struct xrt_root_ioctl_get_res {
> > +	struct resource *xpigr_res;
> > +};
> > +
> > +struct xrt_root_ioctl_get_id {
> > +	unsigned short  xpigi_vendor_id;
> > +	unsigned short  xpigi_device_id;
> > +	unsigned short  xpigi_sub_vendor_id;
> > +	unsigned short  xpigi_sub_device_id;
> > +};
> > +
> > +struct xrt_root_ioctl_hwmon {
> > +	bool xpih_register;
> > +	const char *xpih_name;
> > +	void *xpih_drvdata;
> > +	const struct attribute_group **xpih_groups;
> > +	struct device *xpih_hwmon_dev;
> > +};
> > +
> > +typedef int (*xrt_subdev_root_cb_t)(struct device *, void *, u32, void *);
> This function pointer type is important, please add a comment about its use and expected parameters
> > +int xrt_subdev_root_request(struct platform_device *self, u32 cmd, void *arg);
> > +
> > +/*
> > + * Defines physical function (MPF / UPF) specific operations
> > + * needed in common root driver.
> > + */
> > +struct xroot_pf_cb {
> > +	void (*xpc_hot_reset)(struct pci_dev *pdev);
> This is only ever set to xmgmt_root_hot_reset, why is this abstraction needed ?
> > +};
> > +
> > +int xroot_probe(struct pci_dev *pdev, struct xroot_pf_cb *cb, void **root);
> > +void xroot_remove(void *root);
> > +bool xroot_wait_for_bringup(void *root);
> > +int xroot_add_vsec_node(void *root, char *dtb);
> > +int xroot_create_group(void *xr, char *dtb);
> > +int xroot_add_simple_node(void *root, char *dtb, const char *endpoint);
> > +void xroot_broadcast(void *root, enum xrt_events evt);
> > +
> > +#endif	/* _XRT_ROOT_H_ */
> > diff --git a/drivers/fpga/xrt/mgmt/root.c b/drivers/fpga/xrt/mgmt/root.c
> > new file mode 100644
> > index 000000000000..583a37c9d30c
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/mgmt/root.c
> > @@ -0,0 +1,342 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx Alveo Management Function Driver
> > + *
> > + * Copyright (C) 2020-2021 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *	Cheng Zhen <maxz@xilinx.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/aer.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/delay.h>
> > +
> > +#include "xroot.h"
> > +#include "main-impl.h"
> > +#include "metadata.h"
> > +
> > +#define XMGMT_MODULE_NAME	"xmgmt"
> The xrt modules would be more easily identified with a 'xrt' prefix instead of 'x'
> > +#define XMGMT_DRIVER_VERSION	"4.0.0"
> > +
> > +#define XMGMT_PDEV(xm)		((xm)->pdev)
> > +#define XMGMT_DEV(xm)		(&(XMGMT_PDEV(xm)->dev))
> > +#define xmgmt_err(xm, fmt, args...)	\
> > +	dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > +#define xmgmt_warn(xm, fmt, args...)	\
> > +	dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > +#define xmgmt_info(xm, fmt, args...)	\
> > +	dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > +#define xmgmt_dbg(xm, fmt, args...)	\
> > +	dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > +#define XMGMT_DEV_ID(_pcidev)			\
> > +	({ typeof(_pcidev) (pcidev) = (_pcidev);	\
> > +	((pci_domain_nr((pcidev)->bus) << 16) |	\
> > +	PCI_DEVID((pcidev)->bus->number, 0)); })
> > +
> > +static struct class *xmgmt_class;
> > +static const struct pci_device_id xmgmt_pci_ids[] = {
> > +	{ PCI_DEVICE(0x10EE, 0xd020), }, /* Alveo U50 (golden image) */
> > +	{ PCI_DEVICE(0x10EE, 0x5020), }, /* Alveo U50 */
> 
> demagic this table, look at dfl-pci for how to use existing #define for the vendor and create a new on for the device.  If there are vf's add them at the same time.
> 
> What is a golden image ?
> 
> > +	{ 0, }
> > +};
> > +
> > +struct xmgmt {
> > +	struct pci_dev *pdev;
> > +	void *root;
> > +
> > +	bool ready;
> > +};
> > +
> > +static int xmgmt_config_pci(struct xmgmt *xm)
> > +{
> > +	struct pci_dev *pdev = XMGMT_PDEV(xm);
> > +	int rc;
> > +
> > +	rc = pcim_enable_device(pdev);
> > +	if (rc < 0) {
> > +		xmgmt_err(xm, "failed to enable device: %d", rc);
> > +		return rc;
> > +	}
> > +
> > +	rc = pci_enable_pcie_error_reporting(pdev);
> > +	if (rc)
> > +		xmgmt_warn(xm, "failed to enable AER: %d", rc);
> > +
> > +	pci_set_master(pdev);
> > +
> > +	rc = pcie_get_readrq(pdev);
> Review this call, it does not go negative
> > +	if (rc < 0) {
> > +		xmgmt_err(xm, "failed to read mrrs %d", rc);
> > +		return rc;
> > +	}
> this is a quirk, add a comment.
> > +	if (rc > 512) {
> > +		rc = pcie_set_readrq(pdev, 512);
> > +		if (rc) {
> > +			xmgmt_err(xm, "failed to force mrrs %d", rc);
> similar calls do not fail here.
> > +			return rc;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int xmgmt_match_slot_and_save(struct device *dev, void *data)
> > +{
> > +	struct xmgmt *xm = data;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
> > +		pci_cfg_access_lock(pdev);
> > +		pci_save_state(pdev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void xmgmt_pci_save_config_all(struct xmgmt *xm)
> > +{
> > +	bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_save);
> 
> This is a bus call, not a device call.
> 
> Can this be changed into something like what hot reset does ?
> 
> > +}
> > +
> > +static int xmgmt_match_slot_and_restore(struct device *dev, void *data)
> > +{
> > +	struct xmgmt *xm = data;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
> > +		pci_restore_state(pdev);
> > +		pci_cfg_access_unlock(pdev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void xmgmt_pci_restore_config_all(struct xmgmt *xm)
> > +{
> > +	bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_restore);
> > +}
> > +
> > +static void xmgmt_root_hot_reset(struct pci_dev *pdev)
> > +{
> > +	struct xmgmt *xm = pci_get_drvdata(pdev);
> > +	struct pci_bus *bus;
> > +	u8 pci_bctl;
> > +	u16 pci_cmd, devctl;
> > +	int i, ret;
> > +
> > +	xmgmt_info(xm, "hot reset start");
> > +
> > +	xmgmt_pci_save_config_all(xm);
> > +
> > +	pci_disable_device(pdev);
> > +
> > +	bus = pdev->bus;
> > +
> > +	/*
> > +	 * When flipping the SBR bit, device can fall off the bus. This is
> > +	 * usually no problem at all so long as drivers are working properly
> > +	 * after SBR. However, some systems complain bitterly when the device
> > +	 * falls off the bus.
> > +	 * The quick solution is to temporarily disable the SERR reporting of
> > +	 * switch port during SBR.
> > +	 */
> > +
> > +	pci_read_config_word(bus->self, PCI_COMMAND, &pci_cmd);
> > +	pci_write_config_word(bus->self, PCI_COMMAND,
> > +			      (pci_cmd & ~PCI_COMMAND_SERR));
> > +	pcie_capability_read_word(bus->self, PCI_EXP_DEVCTL, &devctl);
> > +	pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL,
> > +				   (devctl & ~PCI_EXP_DEVCTL_FERE));
> > +	pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
> > +	pci_bctl |= PCI_BRIDGE_CTL_BUS_RESET;
> > +	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
> 
> how the pci config values are set and cleared should be consistent.
> 
> this call should be
> 
> pci_write_config_byte (... pci_bctl | PCI_BRIDGE_CTL_BUF_RESET )
> 
> and the next &= avoided
> 
> > +
> > +	msleep(100);
> > +	pci_bctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> > +	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
> > +	ssleep(1);
> > +
> > +	pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, devctl);
> > +	pci_write_config_word(bus->self, PCI_COMMAND, pci_cmd);
> > +
> > +	ret = pci_enable_device(pdev);
> > +	if (ret)
> > +		xmgmt_err(xm, "failed to enable device, ret %d", ret);
> > +
> > +	for (i = 0; i < 300; i++) {
> > +		pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
> > +		if (pci_cmd != 0xffff)
> what happens with i == 300 and pci_cmd is still 0xffff ?
> > +			break;
> > +		msleep(20);
> > +	}
> > +
> > +	xmgmt_info(xm, "waiting for %d ms", i * 20);
> > +	xmgmt_pci_restore_config_all(xm);
> > +	xmgmt_config_pci(xm);
> > +}
> > +
> > +static int xmgmt_create_root_metadata(struct xmgmt *xm, char **root_dtb)
> > +{
> > +	char *dtb = NULL;
> > +	int ret;
> > +
> > +	ret = xrt_md_create(XMGMT_DEV(xm), &dtb);
> > +	if (ret) {
> > +		xmgmt_err(xm, "create metadata failed, ret %d", ret);
> > +		goto failed;
> > +	}
> > +
> > +	ret = xroot_add_vsec_node(xm->root, dtb);
> > +	if (ret == -ENOENT) {
> > +		/*
> > +		 * We may be dealing with a MFG board.
> > +		 * Try vsec-golden which will bring up all hard-coded leaves
> > +		 * at hard-coded offsets.
> > +		 */
> > +		ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_VSEC_GOLDEN);
> 
> Manufacturing diagnostics ?
> 
> Tom
> 
> > +	} else if (ret == 0) {
> > +		ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_MGMT_MAIN);
> > +	}
> > +	if (ret)
> > +		goto failed;
> > +
> > +	*root_dtb = dtb;
> > +	return 0;
> > +
> > +failed:
> > +	vfree(dtb);
> > +	return ret;
> > +}
> > +
> > +static ssize_t ready_show(struct device *dev,
> > +			  struct device_attribute *da,
> > +			  char *buf)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct xmgmt *xm = pci_get_drvdata(pdev);
> > +
> > +	return sprintf(buf, "%d\n", xm->ready);
> > +}
> > +static DEVICE_ATTR_RO(ready);
> > +
> > +static struct attribute *xmgmt_root_attrs[] = {
> > +	&dev_attr_ready.attr,
> > +	NULL
> > +};
> > +
> > +static struct attribute_group xmgmt_root_attr_group = {
> > +	.attrs = xmgmt_root_attrs,
> > +};
> > +
> > +static struct xroot_pf_cb xmgmt_xroot_pf_cb = {
> > +	.xpc_hot_reset = xmgmt_root_hot_reset,
> > +};
> > +
> > +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +	int ret;
> > +	struct device *dev = &pdev->dev;
> > +	struct xmgmt *xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
> > +	char *dtb = NULL;
> > +
> > +	if (!xm)
> > +		return -ENOMEM;
> > +	xm->pdev = pdev;
> > +	pci_set_drvdata(pdev, xm);
> > +
> > +	ret = xmgmt_config_pci(xm);
> > +	if (ret)
> > +		goto failed;
> > +
> > +	ret = xroot_probe(pdev, &xmgmt_xroot_pf_cb, &xm->root);
> > +	if (ret)
> > +		goto failed;
> > +
> > +	ret = xmgmt_create_root_metadata(xm, &dtb);
> > +	if (ret)
> > +		goto failed_metadata;
> > +
> > +	ret = xroot_create_group(xm->root, dtb);
> > +	vfree(dtb);
> > +	if (ret)
> > +		xmgmt_err(xm, "failed to create root group: %d", ret);
> > +
> > +	if (!xroot_wait_for_bringup(xm->root))
> > +		xmgmt_err(xm, "failed to bringup all groups");
> > +	else
> > +		xm->ready = true;
> > +
> > +	ret = sysfs_create_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
> > +	if (ret) {
> > +		/* Warning instead of failing the probe. */
> > +		xmgmt_warn(xm, "create xmgmt root attrs failed: %d", ret);
> > +	}
> > +
> > +	xroot_broadcast(xm->root, XRT_EVENT_POST_CREATION);
> > +	xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
> > +	return 0;
> > +
> > +failed_metadata:
> > +	(void)xroot_remove(xm->root);
> > +failed:
> > +	pci_set_drvdata(pdev, NULL);
> > +	return ret;
> > +}
> > +
> > +static void xmgmt_remove(struct pci_dev *pdev)
> > +{
> > +	struct xmgmt *xm = pci_get_drvdata(pdev);
> > +
> > +	xroot_broadcast(xm->root, XRT_EVENT_PRE_REMOVAL);
> > +	sysfs_remove_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
> > +	(void)xroot_remove(xm->root);
> > +	pci_disable_pcie_error_reporting(xm->pdev);
> > +	xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
> > +}
> > +
> > +static struct pci_driver xmgmt_driver = {
> > +	.name = XMGMT_MODULE_NAME,
> > +	.id_table = xmgmt_pci_ids,
> > +	.probe = xmgmt_probe,
> > +	.remove = xmgmt_remove,
> > +};
> > +
> > +static int __init xmgmt_init(void)
> > +{
> > +	int res = 0;
> > +
> > +	res = xmgmt_main_register_leaf();
> > +	if (res)
> > +		return res;
> > +
> > +	xmgmt_class = class_create(THIS_MODULE, XMGMT_MODULE_NAME);
> > +	if (IS_ERR(xmgmt_class))
> > +		return PTR_ERR(xmgmt_class);
> > +
> > +	res = pci_register_driver(&xmgmt_driver);
> > +	if (res) {
> > +		class_destroy(xmgmt_class);
> > +		return res;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static __exit void xmgmt_exit(void)
> > +{
> > +	pci_unregister_driver(&xmgmt_driver);
> > +	class_destroy(xmgmt_class);
> > +	xmgmt_main_unregister_leaf();
> > +}
> > +
> > +module_init(xmgmt_init);
> > +module_exit(xmgmt_exit);
> > +
> > +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
> > +MODULE_VERSION(XMGMT_DRIVER_VERSION);
> > +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
> > +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
> > +MODULE_LICENSE("GPL v2");
> 
- Moritz
