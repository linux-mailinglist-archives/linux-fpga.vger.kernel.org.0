Return-Path: <linux-fpga+bounces-53-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C987E80B50F
	for <lists+linux-fpga@lfdr.de>; Sat,  9 Dec 2023 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549B9280FB6
	for <lists+linux-fpga@lfdr.de>; Sat,  9 Dec 2023 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC291641F;
	Sat,  9 Dec 2023 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVTvsVVz"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8BAFB;
	Sat,  9 Dec 2023 07:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702135778; x=1733671778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DrDxsHAvENsxX7mbYnl09JQ4cUEtmC2dirXnkaw6HZc=;
  b=WVTvsVVzyHmKOi9Zq4W/4dUXNlB4zIUCTIjXcpUy8gsdjefU/7nrly1f
   41zIxmrxMrfHQqUEnyULQEo17fVmW7f558RFRpmxmN9jHc33ooLV4d/rT
   PE+stOoFTTXfvHBwxTPinS92KpAC0yc1vFSYjZYli1CAXXXrh14PaGjfb
   cuMwX95n9vZbENDpRhVYIVwoNmHRcaRdr/AKyjVtV6PPqzQ8zeUepc/vS
   wqiXHZXKFU7KUkoxfUlLV59osbECJVK59Iq/nhsv4i4Lf4FSfkthCiYsP
   izQo45phFmPKyB4mF0D2yRqi4t2sYQga4KDlYBxJmC35mtRHsvtTehjo6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1387975"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1387975"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 07:29:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1103890949"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1103890949"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 09 Dec 2023 07:29:35 -0800
Date: Sat, 9 Dec 2023 23:27:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] fpga: add a module owner field to
 fpga_manager and fpga_manager_ops
Message-ID: <ZXSHVguFadvfaUcO@yilunxu-OptiPlex-7050>
References: <20231124162807.238724-1-marpagan@redhat.com>
 <20231124162807.238724-2-marpagan@redhat.com>
 <ZWG6Tg0egX6Cy9j5@yilunxu-OptiPlex-7050>
 <7004d215-5185-4cce-a51e-42e131a30453@redhat.com>
 <ZWsgFViqdJuC7N1d@yilunxu-OptiPlex-7050>
 <5a8819ad-3551-475e-a645-1a300d3373f1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a8819ad-3551-475e-a645-1a300d3373f1@redhat.com>

> >>> I feel the scope of the protection is unclear to me in this patch. What
> >>> data should be protected from concurrent access by this mutex? From the
> >>> code seems the racing of mgr dev should be protected but apparently it
> >>> doesn't have to.
> >>
> >> The mutex is there to ensure the lifetime of the manager device and
> >> its context (struct fpga_manager) if fpga_mgr_get() happens to run
> >> concurrently with the removal of the low-level module.
> >>
> >>>
> >>> And with this mutex, the get/put/unregister() for one mgr should be
> >>> exclusive with another mgr, but that also seems not necessary.
> >>>
> >>
> >> I decided to use a static mutex because I thought putting the mutex
> >> in the manager's context would be unsafe since its life would be tied
> >> to the manager's life. For instance, consider the following sequence:
> >>
> >> - A removes the low-level control module, and delete_module progresses
> >> up to the point when it calls the module's exit function, which in turn
> >> calls fpga_mgr_unregister().
> >>
> >> - fpga_mgr_unregister() takes the mutex but gets descheduled before
> >> completing the unregistering of the manager device.
> >>
> >> - Meanwhile, B wants to get the manager (it is still there) and calls
> >> fpga_mgr_get(), which tries to take the mutex but gets suspended since
> >> it is held by A.
> >>
> >> - A resumes and fpga_mgr_unregister() releases the manager device and
> > 
> > The lifecycle of the manager device is not entirely decided by
> > fpga_mgr_unregister(), this func just puts/decreases the device
> > refcount.
> 
> Right, but here I'm considering the case where no one has previously
> taken the manager device. In that specific case, the refcount will be

I don't think this is valid, anyone should firstly get the manager
device via get_device() then try to access its context.

> decremented to zero, and the device (with its context) will be released.

If no one has taken the manager device, the device & its context are
safe to be released.

> 
> However, you got me thinking about how the mutex is causing the problem
> in this case.
> 
> > 
> > Remember fpga_mgr_get() gets the device via
> > class_find_device()->get_device(). I assume if the valid device pointer
> > could be returned by class_find_device(), it would never be released by
> > other nice players. So I have no worry about the per manager mutex.
> > 
> >> its context, including the mutex on which B is suspended.
> >>
> >> We could mitigate this specific case using mutex_trylock(). However,
> >> there will still be other problematic cases, like if fpga_mgr_get()
> >> gets suspended right before taking the mutex and then delete_module
> >> proceeds up to when fpga_mgr_unregister() frees the manager device
> >> and its context.
> >>
> >>> I think the mgr->owner & mgr->ops should be protected from concurrent
> >>> access of delete_module & fpga_mgr_get/put(), so how about:
> >>>
> >>> struct fpga_manager_ops {
> >>> 	struct module *owner;
> >>> 	...
> >>> };
> >>>
> >>> struct fpga_manager {
> >>> 	...
> >>> 	struct mutex mops_lock;
> >>> 	const struct fpga_manager_ops *mops;
> >>> 	...
> >>> };
> >>>
> >>>
> >>> static struct fpga_manager *__fpga_mgr_get(struct device *dev)
> >>> {
> >>> 	struct fpga_manager *mgr;
> >>>
> >>> 	mgr = to_fpga_manager(dev);
> >>>
> >>> 	mutex_lock(&mgr->mops_lock);
> >>>
> >>> 	if (!mgr->mops || !try_module_get(mgr->mops->owner))
> >>> 		mgr = ERR_PTR(-ENODEV);
> >>>
> >>> 	mutex_unlock(&mgr->mops_lock);
> >>> 		
> >>> 	return mgr;
> >>> }
> >>>
> >>> void fpga_mgr_unregister(struct fpga_manager *mgr)
> >>> {
> >>> 	fpga_mgr_fpga_remove(mgr);	
> >>>
> >>> 	mutex_lock(&mgr->ops_lock);
> >>> 	mgr->mops = NULL;
> >>> 	mutex_unlock(&mgr->ops_lock);
> >>>
> >>> 	device_unregister(&mgr->dev);	
> >>> }
> >>>
> >>> Not actually tested.
> >>>
> >>
> >> I think protecting the only the ops is not enough for the same reasons.
> >> If fpga_mgr_get() gets suspended right after class_find_device(),and
> >> meanwhile the low-level module is removed, it resumes with a reference
> >> to a manager device that no longer exists.
> >>
> >> In a certain sense, however, using a mutex seems like a mitigation
> >> that does not solve the problem at its root. I honestly still think
> >> that taking the module's refcount right when registering the manager
> >> is the only way that is both safe and robust against code changes.
> > 
> > I would nak either. As mentioned above, that makes rmmod vendor module
> > impossible. Introducing another user interface to release the module's
> > refcount is also a bad idea. Who decides to take the ref, who releases
> > it. A user has no knowledge of what is happening inside and should not
> > enforce.
> > 
> >> However, my proposal was rejected.
> >>
> >> So, if you prefer, I can drop the mutex entirely in the next version,
> >> and we leave the responsibility of keeping all kernel pieces to the
> > 
> > No, please try to fix it. Could you please reconsider my proposal?
> > 
> 
> I have considered it and thought about it. However, I don't think we need a
> mutex to protect mgr->mops. This is because the low-level module's refcount has
> already been decremented when fpga_mgr_unregister() is called by the module's
> exit function. So, when we get to the point of executing fpga_mgr_unregister(),
> any concurrent call to try_module_get() will fail (if no one has taken the

Are you still taking care of your previous finding [1]? It says:

  To be clear, you should only use try_module_get() *iff* you are 100% sure
  the module already does exist ...

IIUC, if you do nothing on fpga_mgr_unregister(), the low-level module may
just disappear and any copy of the owner pointer became invalid. Then
try_module_get() would not fail but panic.

[1] 557aafac1153 ("kernel/module: add documentation for try_module_get()")

Thanks,
Yilun

> module before) without the need to check mops first.
> 
> If we assume (as you pointed out) that class_find_device() can be safely
> executed concurrently with device_unregister() (returning either a valid dev
> pointer or null) and, consequently, the manager context is guaranteed to exist
> after that point. Then, we should be good without the mutex if we call
> try_module_get() on a copy of the owner pointer stored in the manager context.
> 
> >> user. It will still be an improvement over taking the low-level
> >> module's refcount through the parent device's driver pointer.
> >>
> 
> Thanks,
> Marco
> 
> 

