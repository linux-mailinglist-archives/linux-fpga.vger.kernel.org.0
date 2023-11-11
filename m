Return-Path: <linux-fpga+bounces-4-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B257E8A70
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Nov 2023 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0F01F20F14
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Nov 2023 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8797912B74;
	Sat, 11 Nov 2023 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZzM5DqBs"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C312B61
	for <linux-fpga@vger.kernel.org>; Sat, 11 Nov 2023 11:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91023C433C8;
	Sat, 11 Nov 2023 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699700562;
	bh=VkzEk2G8M/IH667WMnhkEfu1xxxWypOT/8U1uxpfOeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzM5DqBsBU8jvmoWYqm1DHgIFygZG8ppasjXy38eTaslrANgCR2FPCe7S1b3sK7Qb
	 9XBWnB+ztPiE6luSRAT+uMydCwEjzBMMHGPvtKgYMI1uBmnvUY5VAvD3wEvrSuGRiq
	 xDx3CND3eBQz3eg1kdNm+YxygN78ls+nQ4f1xGHw=
Date: Sat, 11 Nov 2023 06:02:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marco Pagani <marpagan@redhat.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Alan Tull <atull@opensource.altera.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <2023111139-dramatize-spherical-cf43@gregkh>
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
 <5c3c3905-67c2-4cc2-8477-c6fc74676fc9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3c3905-67c2-4cc2-8477-c6fc74676fc9@redhat.com>

On Fri, Nov 10, 2023 at 11:58:37PM +0100, Marco Pagani wrote:
> 
> 
> On 2023-11-08 16:52, Xu Yilun wrote:
> > On Fri, Nov 03, 2023 at 09:31:02PM +0100, Marco Pagani wrote:
> >>
> >>
> >> On 2023-10-30 09:32, Xu Yilun wrote:
> >>> On Fri, Oct 27, 2023 at 05:29:27PM +0200, Marco Pagani wrote:
> >>>> Remove unnecessary module reference counting from the core components
> >>>> of the subsystem. Low-level driver modules cannot be removed before
> >>>> core modules since they use their exported symbols.
> >>>
> >>> Could you help show the code for this conclusion?
> >>>
> >>> This is different from what I remember, a module cannot be removed when
> >>> its exported symbols are being used by other modules. IOW, the core
> >>> modules cannot be removed when there exist related low-level driver
> >>> modules. But the low-level driver modules could be removed freely
> >>> without other protecting mechanism.
> >>>
> >>
> >> My understanding was that we wanted to remove module reference counting
> >> from the fpga core and ease it from the responsibility of preventing
> >> low-level driver modules from being unloaded. 
> > 
> > FPGA core needs to prevent low-level driver module unloading sometimes,
> > e.g. when region reprograming is in progress. That's why we get fpga
> > region driver modules & bridge modules in fpga_region_program_fpga().
> > 
> > But we try best to get them only necessary. Blindly geting them all the
> > time results in no way to unload all modules (core & low level modules).
> > 
> >>
> >> If we want to keep reference counting in the fpga core, we could add a
> >> struct module *owner field in the struct fpga_manager_ops (and others
> >> core *_ops) so that the low-level driver can set it to THIS_MODULE.
> >> In this way, we can later use it in fpga_mgr_register() to bump up the
> > 
> > Yes, we should pass the module owner in fpga_mgr_register(), but could
> > not bump up its refcount at once.
> > 
> >> refcount of the low-level driver module by calling
> >> try_module_get(mgr->mops->owner) directly when it registers the manager.
> >> Finally, fpga_mgr_unregister() would call module_put(mgr->mops->owner)
> >> to allow unloading the low-level driver module.
> > 
> > As mentioned above, that makes problem. Most of the low level driver
> > modules call fpga_mgr_unregister() on module_exit(), but bumping up
> > their module refcount prevents module_exit() been executed. That came
> > out to be a dead lock.
> >
> 
> Initially, I considered calling try_module_get(mgr->mops->owner)
> in fpga_mgr_get(). But then, the new kernel-doc description of
> try_module_get() (1) made me question the safety of that approach.
> My concern is that the low-level driver could be removed right when
> someone is calling fpga_mgr_get() and hasn't yet reached
> try_module_get(mgr->mops->owner).

Can that really happen?  This shouldn't be a real issue, but normally
this should only be needed on an open() like call, don't tie a module
reference to a device reference, those are two different things.

> In that case, the struct mops
> (along with the entire low-level driver module) and the manager dev
> would "disappear" under the feet of fpga_mgr_get().

You should have a lock for handling this anyway, this feels odd that
it's a problem, but I haven't looked at the code in a long time.

try it and see!

greg k-h

