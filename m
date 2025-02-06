Return-Path: <linux-fpga+bounces-1039-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21934A29F90
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 05:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A071165C78
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447714A617;
	Thu,  6 Feb 2025 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQqFdbdN"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302042AB4;
	Thu,  6 Feb 2025 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738815381; cv=none; b=XgckqGbu5r8XErmUIeT1o5uHDa/fjhkYX2LUJ5x4+PuTv/Y004nEQXky7UaYUPYn8cDQSJW2xyxI7v9UkLhHTTsGl33+9doPG1EN944XLaprrP3ZQoyJuReVR6O72lnn2bbzQbprpyY4HYRhy8BmdWqtDwwngcuty4XQyLqCNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738815381; c=relaxed/simple;
	bh=4s3sILqFlowuVPjG6GdU0he0O6BERybC1R9EnR07xaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlArfX/Mp5fdV9eKmy6j2YKlpoijI+HCW6tG7/k6iF7ywg9giGPd1FhslRhOMSC3J7M9H9oFoncftXZxjlCUgiV8dOt9J7wuz5J3QHbDbMvslG/PqyF6XBWf6wmiDtkLVjXjQ5ffzm1hZrQEa3WG0a+9ki/ybuX5IS2XNZgEFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQqFdbdN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738815381; x=1770351381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4s3sILqFlowuVPjG6GdU0he0O6BERybC1R9EnR07xaU=;
  b=RQqFdbdNMB7m1+wQNkea1yXXotl9nbLdND28ueJNY0Q/NXd6Yjq0Laj8
   SmAzw+c4bFoduM6rdhEjvoJHlys3cw1iZNh3vrW6X4axGiUHlGpDtSEOI
   mIq1dCwelPneHtr/azzMrWwYbZW+foh4cDKd74MLYHf9xP4es6KtF97Bf
   nSBR0qgsZ5Rin4+48nb8qpeR0Xdg9SkUde1+DtqPokiKiqbGxlB10oaJ6
   6g9BX6iPMEB8PCOom0g2fHS6k3MPiJIIhz3mDu0/BCzsdPRu8lIA1C5IT
   aC72J6HtNU67VRzisz87MktqDUkA8K+XTf3CkGvjdPvcnpd9p0TzhAUTu
   Q==;
X-CSE-ConnectionGUID: P9kDzEzuSFOJcsUj0TSbow==
X-CSE-MsgGUID: s5IrIscGQc25W9OcNapXbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49649784"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="49649784"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 20:16:19 -0800
X-CSE-ConnectionGUID: GswcwIFiTOGXiY3G6tEpAA==
X-CSE-MsgGUID: OLfJOYpMQ82w452uAM9kTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148292679"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 05 Feb 2025 20:16:15 -0800
Date: Thu, 6 Feb 2025 12:15:23 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>,
	Hayden Laccabue <hayden.laccabue@amd.com>
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
Message-ID: <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
 <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
 <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>

On Sun, Jan 26, 2025 at 11:46:54AM -0800, Yidong Zhang wrote:
> 
> 
> On 1/26/25 02:32, Xu Yilun wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Tue, Dec 10, 2024 at 10:37:30AM -0800, Yidong Zhang wrote:
> > > AMD Versal based PCIe card, including V70, is designed for AI inference
> > > efficiency and is tuned for video analytics and natural language processing
> > > applications.
> > > 
> > > The driver architecture:
> > > 
> > >    +---------+  Communication +---------+  Remote  +-----+------+
> > >    |         |  Channel       |         |  Queue   |     |      |
> > >    | User PF | <============> | Mgmt PF | <=======>| FW  | FPGA |
> > >    +---------+                +---------+          +-----+------+
> > >      PL Data                    base FW
> > >                                 APU FW
> > >                                 PL Data (copy)
> > >   - PL (FPGA Program Logic)
> > >   - FW (Firmware)
> > > 
> > > There are 2 separate drivers from the original XRT[1] design.
> > >   - UserPF driver
> > >   - MgmtPF driver
> > > 
> > > The new AMD versal-pci driver will replace the MgmtPF driver for Versal
> > > PCIe card.
> > > 
> > > The XRT[1] is already open-sourced. It includes solution of runtime for
> > > many different type of PCIe Based cards. It also provides utilities for
> > > managing and programming the devices.
> > > 
> > > The AMD versal-pci stands for AMD Versal brand PCIe device management
> > > driver. This driver provides the following functionalities:
> > > 
> > >     - module and PCI device initialization
> > >       this driver will attach to specific device id of V70 card;
> > >       the driver will initialize itself based on bar resources for
> > >       - communication channel:
> > >         a hardware message service between mgmt PF and user PF
> > >       - remote queue:
> > >         a hardware queue based ring buffer service between mgmt PF and PCIe
> > >         hardware firmware for programming FPGA Program Logic, loading
> > >         firmware and checking card healthy status.
> > > 
> > >     - programming FW
> > >       - The base FW is downloaded onto the flash of the card.
> > >       - The APU FW is downloaded once after a POR (power on reset).
> > >       - Reloading the MgmtPF driver will not change any existing hardware.
> > > 
> > >     - programming FPGA hardware binaries - PL Data
> > >      - using fpga framework ops to support re-programing FPGA
> > >      - the re-programming request will be initiated from the existing UserPF
> > >        driver only, and the MgmtPF driver load the matched PL Data after
> > >        receiving request from the communication channel. The matching PL
> > 
> > I think this is not the way the FPGA generic framework should do. A FPGA
> > region user (your userPF driver) should not also be the reprogram requester.
> > The user driver cannot deal with the unexpected HW change if it happens.
> > Maybe after reprogramming, the user driver cannot match the device
> > anymore, and if user driver is still working on it, crash.
> 
> One thing to clarify. The current design is:
> 
> The userPF driver is the only requester. The mgmtPF has no uAPI to reprogram
> the FPGA.
> 
> 
> > 
> > The expected behavior is, the FPGA region removes user devices (thus
> > detaches user drivers), does reprogramming, re-enumerates/rescans and
> > matches new devices with new drivers. And I think that's what Nava is
> > working on.
> > 
> 
> Nava's work is different than our current design, our current design is:
> 
> the separate userPF driver will detach all services before requesting to the
> mgmtPF to program the FPGA, and after the programming is done, the userPF
> will re-enumerate/rescan the matching new devices.

That's not align with the Device-Driver Model, A device driver should not
re-enumerate/rescan a matching device.

> 
> The mgmtPF is a util driver which is responsible for communicating with the
> mgmtPF PCIe bar resources.
> 
> 
> > BTW, AFAICS the expected flow is easier to implement for of-fpga-region,
> > but harder for PCI devices. But I think that's the right direction and
> > should try to work it out.
> 
> Could I recap the suggested design if I understand that correctly...
> 
> You are thinking that the mgmtPF (aka. versal-pci) driver should have a uAPI

This should be the unified fpga-region class uAPI.

> to trigger the FPGA re-programing; and using Nava's callback ops to detach
> the separate userPF driver; after re-programing is done, re-attch the userPF

No need to detach a specific driver, remove all devices in the
fpga-region. I imagine this could also be a generic flow for all PCI/e
based FPGA cards.

Thanks,
Yilun

> driver and allow the userPF driver re-enumerate all to match the new
> hardware.
> 
> I think my understanding is correct, it is doable.
> 
> As long as we can keep our userPF driver as separate driver, the code change
> won't be too big.
> 
> > 
> > Thanks,
> > Yilun

