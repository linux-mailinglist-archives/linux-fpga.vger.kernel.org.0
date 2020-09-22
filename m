Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171F527471B
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Sep 2020 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIVRCi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Sep 2020 13:02:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43625 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVRCi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Sep 2020 13:02:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id f18so13017631pfa.10
        for <linux-fpga@vger.kernel.org>; Tue, 22 Sep 2020 10:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z9ae4m6x3ZAzWh1U5RllQaFaWeLmUaSl001dnkjzXxM=;
        b=MVBbdwZLOHnYkn/+3wEbUqehg7Jt50/1nzheQNr6j7Rr0Avnr3kqbXlsVwBY/SgGcR
         1N0B7I3SQChXQRmIzoelX6ZoRuLLi7rlkpZ2I7jS8dL8pCUSh4+ly2ezvbLfHp0k1W3P
         zRAE2yE9o325sravZ7pwGvPIPr2F54nbOJ3VMWlVEzoXXGX0Efa4PL8Lkhek6uZrH2Mo
         1BvYtm5jPDZ96j+fCwByZVjn2ZMYpi0wWYgjLK1LdkN7aaB/EiZH8J+DozBTM7HYizgF
         /Zz9wmiHuRlkT1dOcXHZakBRM/cSH4idVc6bRP1LE7tznIKM4Oarb7RYTuMgdzUUAksx
         uW7A==
X-Gm-Message-State: AOAM530DK+EEVFnre3zJ3yseLUb4L6EhKGIZzu+hCjy2ds1D7LXDh1Bu
        4+fyClxWBHSY2FpydHUixHs=
X-Google-Smtp-Source: ABdhPJyUoQA5pUJT2NDhyhVw2/LrX4O/e+htiNGGCxoXsG+sUpYEHqMV0yL8+VZqZv2neKOI3no2Fw==
X-Received: by 2002:a63:1d60:: with SMTP id d32mr1716701pgm.327.1600794157121;
        Tue, 22 Sep 2020 10:02:37 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id bx22sm2916946pjb.23.2020.09.22.10.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 10:02:36 -0700 (PDT)
Date:   Tue, 22 Sep 2020 10:02:35 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager additional changes for 5.10
Message-ID: <20200922170235.GA55789@epycbox.lan>
References: <20200921000855.GA15612@epycbox.lan>
 <20200922081339.GA1972786@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922081339.GA1972786@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Everyone,

On Tue, Sep 22, 2020 at 10:13:39AM +0200, Greg KH wrote:
> On Sun, Sep 20, 2020 at 05:08:55PM -0700, Moritz Fischer wrote:
> > The following changes since commit 9ba3a0aa09fe505540a3bdd11f0da3b8e9d73055:
> > 
> >   fpga: dfl: create a dfl bus type to support DFL devices (2020-09-09 20:28:16 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-extra-for-5.10
> > 
> > for you to fetch changes up to 41b9b36fe986e15eba0a4220c18d72fa5eb9f0dd:
> > 
> >   fpga: dfl: n3000-nios: Make m10_n3000_info static (2020-09-16 19:16:58 -0700)
> > 
> > ----------------------------------------------------------------
> > FPGA Manager changes for 5.10-rc1
> > 
> > Here is the second set of FPGA changes for the 5.10 merge window.
> > 
> > Mircea's changes are part of a changeset to add support for FPGA based
> > clock drivers.
> > 
> > My change fixed a whitespace error in that patch that I missed when
> > initially applying it.
> > 
> > Xu's changes contain additional changes to support the new DFL bus,
> > including some clean ups, refactoring as well as its first user, the
> > NIOS 3000 driver.
> > 
> > YueHaibing's change addresses a sparse warning.
> > 
> > All patches have been reviewed on the mailing list, and have been in the
> > last few linux-next releases (as part of my for-next branch) without issues.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > 
> > ----------------------------------------------------------------
> > Mircea Caprioru (1):
> >       include: fpga: adi-axi-common.h: add definitions for supported FPGAs
> > 
> > Moritz Fischer (1):
> >       include: fpga: adi-axi-common: Fix leading whitespace in header
> > 
> > Xu Yilun (5):
> >       fpga: dfl: move dfl_device_id to mod_devicetable.h
> >       dfl: add dfl bus support to MODULE_DEVICE_TABLE()
> >       fpga: dfl: fix the comments of type & feature_id fields
> >       fpga: dfl: add support for N3000 Nios private feature
> >       fpga: dfl: move dfl bus related APIs to include/linux/fpga/dfl.h
> > 
> > YueHaibing (1):
> >       fpga: dfl: n3000-nios: Make m10_n3000_info static
> > 
> >  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  49 ++
> >  Documentation/fpga/dfl-n3000-nios.rst              |  73 +++
> >  Documentation/fpga/index.rst                       |   1 +
> >  MAINTAINERS                                        |   3 +-
> >  drivers/fpga/Kconfig                               |  11 +
> >  drivers/fpga/Makefile                              |   2 +
> >  drivers/fpga/dfl-n3000-nios.c                      | 573 +++++++++++++++++++++
> >  drivers/fpga/dfl.c                                 |   1 +
> >  drivers/fpga/dfl.h                                 |  85 +--
> >  include/linux/fpga/adi-axi-common.h                | 103 ++++
> >  include/linux/fpga/dfl.h                           |  86 ++++
> >  include/linux/mod_devicetable.h                    |  12 +
> >  scripts/mod/devicetable-offsets.c                  |   4 +
> >  scripts/mod/file2alias.c                           |  17 +
> 
> It's hard to comment on patches on a pull request, but this series still
> needs some work.
> 
> I'll try to list the patch names here and comments, but really, patches
> would be best to make it easier to review:
> 
> 	0001-include-fpga-adi-axi-common.h-add-definitions-for-su.patch
> 		- no users of any of these things you added, why is this
> 		  patch needed?
> 
> 	0002-fpga-dfl-move-dfl_device_id-to-mod_devicetable.h.patch
> 		- dfl_device_id is not descriptive, it means nothing to
> 		  anyone outside of the fpga subsystem.
> 		- fpga_dfl_device_id perhaps instead?  That gives people
> 		  a chance to know where to look for this
> 
> 	0003-dfl-add-dfl-bus-support-to-MODULE_DEVICE_TABLE.patch
> 		- same "prefix" issues as patch 0002, make it "fpga_dfl"
> 		  please.
> 
> 	0004-fpga-dfl-fix-the-comments-of-type-feature_id-fields.patch
> 		- You talk about 4 bits here, and then point to an
> 		  enumerated type with no actual values set for them at
> 		  all.  How is that possible???
> 
> 	0005-include-fpga-adi-axi-common-Fix-leading-whitespace-i.patch
> 		- wrong usage of "Fixes" in a signed-off-by area, please
> 		  see the submitting patches documentation for the
> 		  correct format.  My scripts, and linux-next's scripts
> 		  would have caught this, making this pull request not
> 		  be able to be accepted anyway...
> 
> 	0006-fpga-dfl-add-support-for-N3000-Nios-private-feature.patch
> 		- module parameters are for drivers written in the
> 		  1990's.  Please just "do the right thing" and make the
> 		  code work properly without having to have custom
> 		  options.  Note this option does not really work if you
> 		  have multiple devices in the system at once, which is
> 		  one reason why we don't use module parameters anymore.
> 
> 	0007-fpga-dfl-move-dfl-bus-related-APIs-to-include-linux-.patch
> 		- no one uses this header file move, so don't do it
> 		  until it is required.

This patch will be the first user:
https://lore.kernel.org/lkml/1600666280-25651-1-git-send-email-yilun.xu@intel.com/

Krzysztof has since explained that this patch should have been on a separate
branch with a tag from me, so he can pull it in.

> 
> 	0008-fpga-dfl-n3000-nios-Make-m10_n3000_info-static.patch
> 		- as patch 0006 is going to be redone, this can be
> 		  merged into that when completed.  Why the original
> 		  developer didn't run sparse on the file to start with,
> 		  I don't know :(
> 
> 
> Wow, 8 out of 8 patches rejected, I think that's a new record!  :)
> 
> thanks,
> 
> greg k-h

Everyone: I've reverted the patches. You've seen the comments, so
if one of the patches above is yours please address the comments and
resend them.

Thanks and sorry for messing this up ...

- Moritz
