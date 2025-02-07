Return-Path: <linux-fpga+bounces-1047-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14631A2BA54
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Feb 2025 05:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410B53A80ED
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Feb 2025 04:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970731DE8AB;
	Fri,  7 Feb 2025 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtOcUr0b"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06C47F4A;
	Fri,  7 Feb 2025 04:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738903316; cv=none; b=U442TDsB7gkQoFxBbwPQr4AAerui55SXjRN0sdgV6ZY/G7zhcSsg4N/wZbE+HD7pCjAfATAbE+ZOZdfei9+KZ0oCxSfHP8ui7UEqBBY6mUuVtt7ddnpgViktMYjeRp6I+PGb6NFQPNT2DQ6HpAQziToDvZsq3Vv0sQZx1GSXiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738903316; c=relaxed/simple;
	bh=PlKndQBatwTKy9+60WtpOETzqjcfWtoczr+gzcJPlRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0yHKbp3+v3YteVE1kmoCOiKN1J9Dtp8ZJugbOygcZSlnViPpSEmgUacpPraQW+qNhSIBySs48CKS6BXqIVYFDdXXP/Biq/nSVJ/bOyQqMZS/ZWJuCa8Qr4M+E7mfgbMHEGt1w4tJRsTP7cwUm9xqBwD/XPnlcNd+FIGdmjtNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtOcUr0b; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738903314; x=1770439314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PlKndQBatwTKy9+60WtpOETzqjcfWtoczr+gzcJPlRY=;
  b=dtOcUr0bBcbAR2U6V1TY55T8Li8yYUnjfPbOal/UNIKuxwBLeM5tdj1h
   ZV81y+ibS0LkiKKb2gsH48YtcM5CQdt304jwEF7wmUo4JlbO+jXIP1Kmf
   ldyy3pmWoW5fxk5nGoMYUOy5CkPU/b04V21LTI+zMArPdWaSCIHTTtZOV
   A6xWLlFlyo09MRUevwVOuIbJdgiWrhnaYOZ4rZNafuy6y+YdVChizcj6M
   7GHkO+1h01jGSlo2tbsMPlqHcijtdX+63ONpTDnBGX8JmNmot0c3MKj9g
   HYhEJEHtZzLzy23Fx3lUp6YDbu1jigh3n6M0bI1NCzRsBP6cOpoJktlZx
   w==;
X-CSE-ConnectionGUID: OdmuComeS0GVi+ZZ8fg5og==
X-CSE-MsgGUID: bU+EeYQnSZeYum/wgNUYeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56954183"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="56954183"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 20:41:53 -0800
X-CSE-ConnectionGUID: R9P02Zz8Tfytm/ep0oBjLA==
X-CSE-MsgGUID: qjxvQInCQ2i4O4/EjflaIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134656767"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 06 Feb 2025 20:41:51 -0800
Date: Fri, 7 Feb 2025 12:40:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>,
	Hayden Laccabue <hayden.laccabue@amd.com>
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
Message-ID: <Z6WO2Ktc9HoqdUSU@yilunxu-OptiPlex-7050>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
 <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
 <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
 <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
 <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
 <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
 <7b9bd24f-8f89-4d6c-a079-47c4c0b88a35@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9bd24f-8f89-4d6c-a079-47c4c0b88a35@amd.com>

On Thu, Feb 06, 2025 at 07:16:25PM -0800, Yidong Zhang wrote:
> 
> 
> On 2/6/25 18:19, Xu Yilun wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > > > No need to detach a specific driver, remove all devices in the
> > > > fpga-region. I imagine this could also be a generic flow for all PCI/e
> > > > based FPGA cards.
> > > 
> > > I see your point. Is there an existing example in current fpga driver for
> > > PCI/e based cards?
> > 
> > No. The fpga-region re-enumeration arch is still WIP, so no existing
> > implementation.
> 
> Got you. I can also help to test or provide feedback.
> Actually, I had sent Nava my protype of using configfs for the non-OF
> driver. He should have the updated patch soon.
> 
> > 
> > > 
> > > We will need to talk to our management team and re-design our driver.
> > > I think we have 2 approaches:
> > > 1) Align with linux fpga, having one driver for both userPF and mgmtPF; or
> > 
> > Don't get you. Linux FPGA doesn't require one driver for both PFs.
> 
> I assume when you said "generic flow for removing all devices in
> fpga-region" means that there is a single driver which use the fpga-region
> callbacks to remove all devices and then re-progream the FPGA.
> 
> On AMD V70 hardware, the userPF has different deviceid than the mgmtPF.
> Thus, our current design is having 2 separate pcie drivers for each
> different deviceid.
> 
> Thus, in our current design, the fpga-region should be in the userPF driver
> which has callbacks to remove all devices. But in mgmtPF, it is more like a

A question, if the FPGA logic is cleared, does the userPF still exist on
PCIe bus?

> utility which only handles request from the userPF but it has the management
> privilege. Usually, cloud vendors require the mgmtPF deployed in their
> secured domain (can be a separate physical machine).

I though mgmtPF & userPF are just 2 functions on one PCIe card, they are not?
Then how the mgmtPF writes data to another physical machine and
influence the userPF?

Thanks,
Yilun

> 
> We can keep 2 drivers, one for userPF, one for mgmtPF. The userPF and mgmtPF
> communicate each other via the communication channel because they can be
> physically on different machine.
> 
> Are you looking for us to upstream both of them together?
> If yes, I still think that the fpga-region should be in the userPF driver.
> The mgmtPF driver is still a utility driver.
> 
> Please correct me if I am wrong.:)
> 
> > 
> > > 2) find a different location (maybe driver/misc) for the version-pci driver,
> > > because it is an utility driver, not need to be tied with fpga framework.
> > 
> > I'm not the misc maintainer, but I assume in-tree utility driver +
> > out-of-tree client driver is not generally welcomed.
> 
> Great info! Thanks! I will have to discuss this with my team too.
> 
> My understanding, so far based on your comments above, the drivers/fpga
> prefer to use fpga-region ops to handle FPGA re-program changes.
> 
> The current versal-pci driver is a utility driver.
> The fpga-region should be within the userPF driver.
> 
> We can try to make our userPF driver in-tree as well. But the current plan
> is to do it later.
> 
> If you prefer we do both of them together. I can talk to my team.
> 
> Thanks,
> David
> > 
> > Thanks,
> > Yilun
> > 
> > > 
> > > Please let me know you thoughts. Which way is acceptable by you.
> > > 
> > > Thanks,
> > > David
> > > > 
> > > > Thanks,
> > > > Yilun
> > > > 
> > > > > driver and allow the userPF driver re-enumerate all to match the new
> > > > > hardware.
> > > > > 
> > > > > I think my understanding is correct, it is doable.
> > > > > 
> > > > > As long as we can keep our userPF driver as separate driver, the code change
> > > > > won't be too big.
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Yilun

