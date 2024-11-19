Return-Path: <linux-fpga+bounces-944-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B29D2095
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 08:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4FF282A4B
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6031531C2;
	Tue, 19 Nov 2024 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmmrC8cb"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634135280;
	Tue, 19 Nov 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000226; cv=none; b=lBTu75+5nbAel0k+eQDsgalbcpfqYLbVKolbAzUKLAwxv7o2deO7SrF+QMArX7yJ/mfPnkxzYK4wjk+YeJ9GLr+WjIzIo2SmWeefxyQMOUtBj6Su1I/qskcQnSkpuEpC4pKa4uWqDUOOOi8frU35B51EDWMHuUIcxRYbKLUvI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000226; c=relaxed/simple;
	bh=iMS7LWVI7+ApG9inlSXXDKL1j2ZtYxqiNrZnJgc/Gew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUYlbMmvWNi1Cdo+6DxN2ScM+8uYWmueUeOTT4ernz33BXDDd1mUJo3Jvs8IBnDgdrG3Pu0fPB+Scx356hkrMWvlApMy8O/f2xOX4UYucVQ67PySaRbk77uZFe/l13NctHRClGpb4sGSdtHnLvB0RI4aSG3IpqtNlwkutlixoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmmrC8cb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732000225; x=1763536225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iMS7LWVI7+ApG9inlSXXDKL1j2ZtYxqiNrZnJgc/Gew=;
  b=FmmrC8cbBScZa45BSoHKwFRnKCYsHadDBTQ/TODzvEwjYTRZqufyIAtG
   zvSICvSudt9BULbQwtOFiwg4EOURy4wj2bVrnCf3VkLBEaRtlcPotUH32
   xtcOT1iulWqc26Yc/HDWzkucpbkc5wxymVnHGvYkbJlz0r+ZJB0t+PJ1o
   ZuRgmMJuI21i6vJ2+wprqZeLME6E5Sg4Euno/i2rmAulxmGg38vgKjENz
   zjL2a8m4/m33Fw2taC59ciZ3QVCHkiLiNNGzg1ttLVnKIm0qiJuK1jTq6
   85c+PsADk73sGKscP6oPBFlz4pCoYVBBccMA8HJ2N7E01gkVIHoDVC47q
   w==;
X-CSE-ConnectionGUID: WYiymd5vSxq710KNafvNJw==
X-CSE-MsgGUID: 1e+Kx/tBQlWAsG91bKPg9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="42500244"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="42500244"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 23:10:24 -0800
X-CSE-ConnectionGUID: jmfIw0UrQoyHyp1a1EA78A==
X-CSE-MsgGUID: r+n0Qu3nRQaoNNOq/X9aYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="93924236"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 18 Nov 2024 23:10:21 -0800
Date: Tue, 19 Nov 2024 15:07:28 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>
Subject: Re: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal
 PCIe card
Message-ID: <Zzw5MOb6dUD6BLYh@yilunxu-OptiPlex-7050>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
 <ZxH9Xjd0eU/7IDGC@yilunxu-OptiPlex-7050>
 <56421e2e-062c-407b-b731-0c1d585a1277@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56421e2e-062c-407b-b731-0c1d585a1277@amd.com>

> > > +obj-$(CONFIG_AMD_VERSAL_MGMT)                        += amd-vmgmt.o
> > 
> > IMHO the naming vmgmt is hard to understand, any better idea?
> 
> The "v" stand for Versal. We would change to amd-vpci for Versal based pcie

"v" + "pci" is quite a misleading term, maybe just versal-pci?

> devices.
> 
>

[...]
 
> > 
> > > +{
> > > +     struct comms_device *ccdev;
> > > +
> > > +     ccdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*ccdev), GFP_KERNEL);
> > > +     if (!ccdev)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     ccdev->vdev = vdev;
> > > +
> > > +     ccdev->regmap = devm_regmap_init_mmio(&vdev->pdev->dev,
> > > +                                           vdev->tbl + COMMS_PCI_BAR_OFF,
> > > +                                           &comms_regmap_config);
> > 
> > I'm not sure why a regmap is needed. All register accessing is within
> > the same module/file, and I assume a base+offset is enough to position
> > the register addr.
> 
> I thought the regmap is preferred. We can use some common APIs like
> regmap_bulk_*. The base+offset works too, then we will implement our own
> bulk_* functions. Please let me know.

I didn't see any regmap_bulk_*. AFAICS regmap is not needed here.

[...]

> > > +     /* create fgpa bridge, region for the base shell */
> > > +     fdev->bridge = fpga_bridge_register(dev, "AMD Versal FPGA Bridge",
> > > +                                         &vmgmt_br_ops, fdev);
> > 
> > I didn't find the br_ops anywhere in this patchset. So how to gate the
> > FPGA region when it is being reprogrammed? What is the physical link
> > between the FPGA region and outside visitors?
> 
> The FPGA region gate operation is done in the FW running in this PCIe card.
> The FW will "freeze" the gate before programing the PL. After downloading
> the new hardware. The FW will then "free" the gate.

So no OS operation is needed, then seems no need the fpga_bridge object.

> 
> No physical link between FPGA region and outside visitors, the FW handles
> all requests.
> 
> > 
> > > +     if (IS_ERR(fdev->bridge)) {
> > > +             vmgmt_err(vdev, "Failed to register FPGA bridge, err %ld",
> > > +                       PTR_ERR(fdev->bridge));
> > > +             ret = PTR_ERR(fdev->bridge);
> > > +             goto unregister_fpga_mgr;
> > > +     }
> > > +
> > > +     region = (struct fpga_region_info) {
> > > +             .compat_id = (struct fpga_compat_id *)&vdev->intf_uuid,
> > > +             .get_bridges = vmgmt_get_bridges,
> > > +             .mgr = fdev->mgr,
> > > +             .priv = fdev,
> > > +     };
> > > +
> > > +     fdev->region = fpga_region_register_full(dev, &region);
> > 
> > I assume the fpga region represents the user PF, is it? If you
> > reprogram the FPGA region, how does the user PF driver aware the HW is
> > changing?
> 
> The HW changing request is always requested from the user PF driver. The

I don't understand. In your patch the FPGA reprograming is triggered by
an IOCTL, usually a userspace application calls it. But here says it is 
triggered by the user PF *driver*, which IIUC is a kernel driver.
Anything I missed?

> user PF driver will make sure it is safe to change hardware. Then, the user
> PF driver notify the mgmt PF driver by a unique identify of the HW bitstream
> (PL Data).
> 
> The mgmt PF driver, the amd-vpci driver, will check the unique identify and
> then find the same PL Data from its local storage which is previously
> installed, and start downloading it.

Is the flow included in this patchset? Please elaborate more.

[...]

> > > +/**
> > > + * VERSAL_MGMT_LOAD_XCLBIN_IOCTL - Download XCLBIN to the device
> > > + *
> > > + * This IOCTL is used to download XCLBIN down to the device.
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +#define VERSAL_MGMT_LOAD_XCLBIN_IOCTL        _IOW(VERSAL_MGMT_MAGIC,         \
> > > +                                          VERSAL_MGMT_BASE + 0, void *)
> > 
> > Many definitions are added in a batch but some are not used in this
> > patch. Please reorganize the patches for easer review, even for first
> > version.
> > 
> > Thanks,
> > Yilun
> 
> Hi Yilun,
> 
> Thanks for taking your time, and yes for sure I will make each patch more
> self-contained.
> 
> Here is my thoughts on upcoming patches structure:
> 1st patch, adding driver probe and FPGA framework; the actual ops

Just adding driver probe for 1st patch please.

Thanks,
Yilun

> of handling communication channel message and remote queue message
> will present as no-op with comments.
> 
> 2nd patch, adding the communication channel services
> 3rd patch, adding the remote queue services
> 4th patch, adding the callers of using the remote queue services
> 
> Thanks,
> David
> 
> > 
> > > +
> > > +#endif /* _UAPI_LINUX_VMGMT_H */
> > > --
> > > 2.34.1
> > > 
> > > 

