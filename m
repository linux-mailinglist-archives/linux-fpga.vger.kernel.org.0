Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88A3E08F0
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Aug 2021 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhHDTsG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Aug 2021 15:48:06 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:56193 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbhHDTsF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Aug 2021 15:48:05 -0400
Received: by mail-wm1-f53.google.com with SMTP id x17so1841369wmc.5
        for <linux-fpga@vger.kernel.org>; Wed, 04 Aug 2021 12:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=63JCtXviRa75YRITsqMmY7CQ0hQSrisGx8q6KTvYjyA=;
        b=eI9799xmQ30wNxcATHltPEH0HyuSy6Ok0TmscmJm+iween1nJm+xw6G90CXAl0nwSg
         RoIWPv3LCALtrcUfEfTfuXoSmFi2JoI4AJ4frv2GOzvzknRpItmBsbYRPfnKliJ12ohH
         cwjiwWcVNaWOu7FCcDlqObCxDApz7gkAOR2ha4vx/ekWFFO2CaFR2BNuTkV0gOjQJqGD
         MjqFon7I0StI0nysrfSdj88BjarbV3J+MR9V9qOgN/L4eA/h3nmKWQT/a/FolZWuRiss
         zJAvZi+aVEQEmtU4BkWoANfS9A7khfmMZca2SRVVDRoCRhWs7A9wk/siRsgWAt04cG4K
         maaQ==
X-Gm-Message-State: AOAM532q8jJ5GBdLXQ/OHEkSoR4uuqLcxXbfNz+WYuxxaT1OY5TTVdbX
        pghCO/8VsXoMN52Di6oBWck=
X-Google-Smtp-Source: ABdhPJwRRo2jcevsZfFEy4kMi4tTmsUivlQNIkHmsjp53gC5Bhy2ZAxZATp5SAGHKSF8xyXiA4S6NQ==
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr11459464wmm.146.1628106470944;
        Wed, 04 Aug 2021 12:47:50 -0700 (PDT)
Received: from localhost ([149.172.45.165])
        by smtp.gmail.com with ESMTPSA id w9sm3175838wmc.19.2021.08.04.12.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 12:47:50 -0700 (PDT)
Date:   Wed, 4 Aug 2021 12:47:48 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
Message-ID: <YQru5Cz8ergCEbIA@archbook>
References: <YKH/6xQ7bEwJzEsM@kroah.com>
 <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
 <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com>
 <YQPgFn/z024U06HJ@kroah.com>
 <85cd4801-ca1f-4482-6999-3d2e648b24e5@intel.com>
 <YQjY+KL59m51kucV@kroah.com>
 <3ba35b3c-3c85-394b-f404-130968587a6f@intel.com>
 <YQpDySXy0ASM5u9y@kroah.com>
 <YQqrGvwkf6bJ/5in@archbook>
 <YQquaUQCb0hIJmre@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQquaUQCb0hIJmre@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 04, 2021 at 05:12:41PM +0200, Greg KH wrote:
> On Wed, Aug 04, 2021 at 07:58:34AM -0700, Moritz Fischer wrote:
> > On Wed, Aug 04, 2021 at 09:37:45AM +0200, Greg KH wrote:
> > > On Tue, Aug 03, 2021 at 12:02:24PM -0700, Russ Weight wrote:
> > > > 
> > > > 
> > > > On 8/2/21 10:49 PM, Greg KH wrote:
> > > > >> If the request_firmware() implementation is not acceptable, then would
> > > > >> you agree that an IOCTL implementation is our best option?
> > > > > There is no difference in the end between using an ioctl, or a sysfs
> > > > > file, to provide the filename of your firmware, don't get hung up on
> > > > > that.
> > > > 
> > > > I meant to suggest that passing file data (not a filename) through an
> > > > IOCTL might be better for this use case than trying to use request_firmware.
> > > > We have to, somehow, allow the user to point us to the desired image
> > > > data (which could be a root-entry-hash, or an FPGA image). We can't
> > > > really use a fixed filename modified by device version as many of
> > > > the devices do.
> > > 
> > > Ah, yes, a "normal" write command might be best for this as that can be
> > > properly containerized and controlled.
> > > 
> > > > > By providing a "filename", you are going around all of the namespace and
> > > > > other "container" protection that the kernel provides, and allowing
> > > > > processes to potentially load files that are normally outside of their
> > > > > scope to the hardware.  If you are willing to allow that security
> > > > > "escape", wonderful, but you better document the heck out of it and
> > > > > explain why this is allowed for your special hardware and use case.
> > > > >
> > > > > As you are expecting this to work "in the cloud", I do not think that
> > > > > the operators of such hardware are really going to be all that happy to
> > > > > see this type of interface given these reasons.
> > > > >
> > > > > What is wrong with the current fpga firmware api that somehow is lacking
> > > > > for your special hardware, that other devices do not have to worry
> > > > > about?
> > > > The existing framework wants to update the live image in the FPGA,
> > > > whereas for this device, we are passing signed data to BMC firmware
> > > > which will store it in FLASH to be loaded on a subsequent boot of
> > > > the card.
> > > > 
> > > > The existing framework needs to manage FPGA state, whereas for this
> > > > device, it is just a transfer of signed data. We also have to handle
> > > > a total transfer/authentication time of up to 45 minutes, so we are
> > > > using a kernel worker thread for the update.
> > > > 
> > > > Perhaps the name, fpga security manager, is wrong? Maybe something
> > > > like fpga_sec_image_xfer is better?
> > > 
> > > It does not sound like this has anything to do with "security", and
> > > rather is just a normal firmware upload, so "fpga_image_upload()"
> > > perhaps?
> > 
> > I had originally suggested 'load' and 'persist' or 'load' and 'update or
> > something of that sort.
> > 
> > Taking one step back, maybe the case could be made for a generic
> > 'persistent firmware' update framework that addresses use-cases that
> > require updating firmware that may take extended periods of time.
> 
> There should not be a problem with using the existing firmware layer for
> images that take long periods of time, as long as you are not wanting to
> see any potential progress :)
> 
> So how about just adding anything missing to the existing firmware
> subsystem.  It's attempting to handle all use cases already, if it is
> missing one, no harm in adding more options there...

Even better if we can do that. It would have a limited overlap with
existing functionality, though.

- Moritz
