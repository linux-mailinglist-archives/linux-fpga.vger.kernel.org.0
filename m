Return-Path: <linux-fpga+bounces-589-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690CD948183
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Aug 2024 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD8C1C21E12
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Aug 2024 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844A615ECC8;
	Mon,  5 Aug 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAryzmEP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA72149DFC;
	Mon,  5 Aug 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882161; cv=none; b=ZBB/1huyngkO9YgPPVQpf+AIfqNG+cUG5bb3w/r8H4a8eW/1y5vw2ZBayK6SbEnawCaxw6Y+sUO4GZ8P6Rjt5YFSYt7LkbdhNRhpQieWL6/yaKSI2y2NoOnCzoFTi6wiL6WlnxHq2Pwl5RnKeAtyzQYSYJ4ApFuRvqWkbJQCpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882161; c=relaxed/simple;
	bh=fLhb7Bf6AnhAS2P94nRjDOP9ObCevjFpbZItCvZLoyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TByyEmBMAjVcPXcexXG76SYHkjDBPEJglQta/eHDRFEJiq8p4+TLb8Cz/i8B3sPR5D+SWqa/e8CPyIBZ8U6Et4C4gY3SDQhNPKoQpXCmPAmy0rd3gMrDvORqqh5/tHRDsyKuHE80cmgIsPvUyUB9TZBXj56YHVoUSq8TcpZJJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAryzmEP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722882159; x=1754418159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLhb7Bf6AnhAS2P94nRjDOP9ObCevjFpbZItCvZLoyg=;
  b=KAryzmEPre/PxEGn3AHUu0uaavrTmwJRuDOMNWINKxieSK5VeuvEtW2e
   ZHZspfUhzaOG9HBIgBtTly3oBgCeX61qE3cwyOOiqdenOufRokjDG9xy4
   d/HJUPZfDQnVTs6aeYURkEAa2uIy9ZVOX0oM8+jZI1fttbgz7LaOqAd+D
   0yeIVa8YpP/ojWM4kiw+Srr2zieaYW+dl1Sm6+Ojp98ueqbDPS9PhDZ03
   U/H006onzyYYnqQtG7J0OqJG3edb2FTk/RPxXBhorlOcwK/lmYOtHmKkU
   hnPrhE3N7GRTNTS8dfHapPa0UKtywSbYnpgegchI9e4bdeHFH1fvdTVyf
   Q==;
X-CSE-ConnectionGUID: Q+1tO6VvTuSVcNt3yILIWg==
X-CSE-MsgGUID: KCwAWSLESc+laNWQCS4p3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20988008"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="20988008"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 11:22:38 -0700
X-CSE-ConnectionGUID: G1VK7kmcS6eaNvWALDRf7w==
X-CSE-MsgGUID: AVWAb0RNSSeuwU6n2SJGTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="87179083"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2024 11:22:36 -0700
Date: Tue, 6 Aug 2024 02:20:36 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc: "git (AMD-Xilinx)" <git@amd.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"saravanak@google.com" <saravanak@google.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA
 configuration
Message-ID: <ZrEX9HlAOlUtgnTj@yilunxu-OptiPlex-7050>
References: <20240726063819.2274324-1-nava.kishore.manne@amd.com>
 <20240726063819.2274324-2-nava.kishore.manne@amd.com>
 <Zqe7yoAMIJ+Qv8YC@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070C9991ED88DFFADA7EC3CCDB22@DS7PR12MB6070.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR12MB6070C9991ED88DFFADA7EC3CCDB22@DS7PR12MB6070.namprd12.prod.outlook.com>

On Thu, Aug 01, 2024 at 04:25:42AM +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Monday, July 29, 2024 9:27 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org; hao.wu@intel.com;
> > yilun.xu@intel.com; trix@redhat.com; robh@kernel.org;
> > saravanak@google.com; linux-fpga@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA
> > configuration
> > 
> > On Fri, Jul 26, 2024 at 12:08:19PM +0530, Nava kishore Manne wrote:
> > > Adds sysfs interface as part of the of-fpga-region. This newly added
> > > sysfs interface uses Device Tree Overlay (DTO) files to
> > > configure/reprogram an FPGA while an operating system is running.This
> > > solution will not change the existing sequence When a DT overlay that
> > > targets an FPGA Region is applied.
> > > 	- Disable appropriate FPGA bridges.
> > > 	- Program the FPGA using the FPGA manager.
> > > 	- Enable the FPGA bridges.
> > > 	- The Device Tree overlay is accepted into the live tree.
> > > 	- Child devices are populated.
> > >
> > > When the overlay is removed, the child nodes will be removed, and the
> > > FPGA Region will disable the bridges.
> > >
> > > Usage:
> > > To configure/reprogram an FPGA region:
> > > echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/load
> > 
> > IIRC, last time we are considering some generic interface for both OF & non-
> > OF FPGA region, but this is still OF specific.
> > 
> At AMD, we exclusively use OF for FPGA configuration/reconfiguration, utilizing overlay files as outlined in the fpga-region.txt documentation.
> However, some devices, like dfl.c those relying solely on the FPGA region, do not use OF. 
> For these non-OF devices, should we expect them to follow the fpga-region.txt guidelines for FPGA configuration/reconfiguration?

I assume it is Documentation/devicetree/bindings/fpga/fpga-region.yaml.

No, Non-OF devices don't have to follow the DT binding.

> If so, it may be advantageous to develop a common interface for both OF and non-OF.
> If not, it might be more appropriate to establish distinct interfaces to cater to their specific requirements.

I think each vendor may have specific way for device enumeration, but
that doesn't mean we need distinct user interfaces. For all FPGA
devices, we should avoid the situation that the HW is changed but
system SW knows nothing. So the common needs are:

 - Find out and remove all devices within the fpga region before
   reprograming.
 - Re-enumerate devices in fpga region after reprograming.

I expect the fpga region class could generally enforce a flow for
the reprograming interface. And of-fpga-region could specifically
implement it using DT overlay.

Thanks,
Yilun

