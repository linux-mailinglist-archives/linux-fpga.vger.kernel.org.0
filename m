Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526BC27507B
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Sep 2020 07:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgIWFyS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Sep 2020 01:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgIWFyS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Sep 2020 01:54:18 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E807C206A5;
        Wed, 23 Sep 2020 05:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600840457;
        bh=pZRfuCYxFbYkhQlZ/4BZiyLOOFGJsGsp/GXKahz7wwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lq5LCXIci8R8mfcUy3ddg3r0vDhU2gUcestNN9E7g25/+zlJY/Kn7hL4DpTDb2Pjo
         LYV/JQ4n6k7zr6tumIEiZGfmLpV/UUdMk5ZT9L/zobJF9sy7BPhOXeej8B3TXHFvLU
         TwdmaHtnIi4Yb+qwG2RmlpNB38mMPZjIfJ/gED70=
Date:   Wed, 23 Sep 2020 07:54:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager additional changes for 5.10
Message-ID: <20200923055436.GA2629915@kroah.com>
References: <20200921000855.GA15612@epycbox.lan>
 <20200922081339.GA1972786@kroah.com>
 <20200922194908.GA29964@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922194908.GA29964@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 23, 2020 at 03:49:08AM +0800, Xu Yilun wrote:
> On Tue, Sep 22, 2020 at 10:13:39AM +0200, Greg KH wrote:
> > 	0002-fpga-dfl-move-dfl_device_id-to-mod_devicetable.h.patch
> > 		- dfl_device_id is not descriptive, it means nothing to
> > 		  anyone outside of the fpga subsystem.
> > 		- fpga_dfl_device_id perhaps instead?  That gives people
> > 		  a chance to know where to look for this
> 
> Yes, I could change to fpga_dfl_device_id.
> And do we also need to change the naming of other dfl bus objects & APIs?
> I tend to not change them because the names would become too long. The
> clue of fpga_dfl_device_id would be enough for people to know where they
> are.

You are now "playing in the namespace of the whole kernel", so yes, you
need to be as descriptive as possible so that everyone knows what is
happening as all subsystems touch these files.

No one knows what "dfl_" means.  Heck, I have no idea, I keep thinking
"Device Firmware Loader" or something like that.

So making it obvious, and unique, and "short enough" is the requirement.

Naming is hard :)

And there is no problem with having "long" names in your drivers, we
have no max numbers of characters that the compiler can accept, this
isn't the 1960's anymore...

> > 	0003-dfl-add-dfl-bus-support-to-MODULE_DEVICE_TABLE.patch
> > 		- same "prefix" issues as patch 0002, make it "fpga_dfl"
> > 		  please.
> > 
> > 	0004-fpga-dfl-fix-the-comments-of-type-feature_id-fields.patch
> > 		- You talk about 4 bits here, and then point to an
> > 		  enumerated type with no actual values set for them at
> > 		  all.  How is that possible???
> 
> I'm sorry I didn't fully understand the issue. Actually the
> enum dfl_id_type is introduced in previous patchset, it contains the
> implied values FME_ID == 0, PORT_ID == 1.

You say "implied", that's the problem.

If you really are going to guarantee that these values are only 4 bits
big, then explicitly set them to that value so we all know what is going
on.

But the bigger question is "why"?  Who cares it's only 4 bits, we have
room in the kernel to have it be a full 8 bits or 32 or whatever, right?

If this is a value shared by hardware or a spec, then you HAVE TO
explicitly set the values of an enumerated type.  Otherwise the compiler
is in its right to do whatever it wants with them (well, within
reason...)

> > 	0005-include-fpga-adi-axi-common-Fix-leading-whitespace-i.patch
> > 		- wrong usage of "Fixes" in a signed-off-by area, please
> > 		  see the submitting patches documentation for the
> > 		  correct format.  My scripts, and linux-next's scripts
> > 		  would have caught this, making this pull request not
> > 		  be able to be accepted anyway...
> > 
> > 	0006-fpga-dfl-add-support-for-N3000-Nios-private-feature.patch
> > 		- module parameters are for drivers written in the
> > 		  1990's.  Please just "do the right thing" and make the
> > 		  code work properly without having to have custom
> > 		  options.  Note this option does not really work if you
> > 		  have multiple devices in the system at once, which is
> > 		  one reason why we don't use module parameters anymore.
> 
> I'm wondering which is the better way to handle the case, but let me
> first describe it.
> 
> The n3000-nios driver will first require the embedded firmware to
> finish some netdev configuration (via the SPI controller) according to
> user's option, then the driver takes over the control of the SPI
> controller and continue to enumerate various devices behind the SPI bus.
> The firmware will never be active again after the first configuration on
> power cycle. So I tend to let the driver finish the configuration
> requirement at probe, then the following drivers for SPI devices could be
> autoloaded. This is why I choose the module parameter.

Remember, module parameters affect ALL devices the driver controls, you
just broke the ability for this driver to handle multiple devices per a
single driver, with no way of ever fixing that (module parameters are
userspace apis...)

> I was considering the sysfs interface option to trigger this one-time
> configuration. But this makes the SPI devices unavailable until user
> inputs something to this sysfs node. We may need to add some specific
> udev rules to make the whole functionalities of the FPGA card enabled
> automatically.

Why can't you figure out the state of the device without having to worry
about a module option?  No one will know how to set that thing, and if
they do, it will get baked into a bootloader somewhere and no one can
ever turn it off.

Be dynamic and make things "just work" so that the user does not have to
configure anything at all please.

> And our customers don't expect different configurations between
> multiple cards on one system, which also influences my decision.

They might not say that today, but you just forced them to never be able
to do that ever, in the next 20+ years :(

thanks,

greg k-h
