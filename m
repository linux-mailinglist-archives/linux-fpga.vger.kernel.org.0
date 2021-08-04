Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483273E03C0
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Aug 2021 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbhHDO6u (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Aug 2021 10:58:50 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:35755 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbhHDO6u (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Aug 2021 10:58:50 -0400
Received: by mail-wm1-f48.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso4171111wms.0
        for <linux-fpga@vger.kernel.org>; Wed, 04 Aug 2021 07:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lhhhiHu36QmjCDBwWTN5hSedfmuOv+3Eol0FOaXtGP8=;
        b=JLCORX39sBsvCaEi4rrqfKE7MXH86V99IlvWGB2eW5hvUjxwM9Q5I8EMcPTgZLfS/e
         PKmTJpTgNTrGVzQj/dF7DWyx+hvEvIeEX3jYbrDTIvL+fG0/yffFA/d0GHUzZLajz4o1
         v6FCo3FjTpFkHlbSegwdgbgmZiQmU45OSEIdQgEGuESLvxj+4nMlzivmfdNA8/5p3cDw
         TXX7jHaFb1vNnGKbCMgbO9k4LtwTy7If945a5atPEhGi8YOcr6eAwZaTMx/P7VEOGEMk
         putxejCOAHpTovDQLvSDcWbi9LkuGWNbdQjIQUrmIGrNJY5zh2fMyTSDK7++hQI9HrHj
         BmoA==
X-Gm-Message-State: AOAM5311NfQloKxEGfy3OXIFK2AXUGxvuxn0dOayMAEC/XvtdcJ2kVSG
        XSfG79IPk9QLB+5III88D64=
X-Google-Smtp-Source: ABdhPJyrScs+H7cWO2Dzv+iPMhtH99UnkGy42vvBdJBkQdJfsaTarGXoE5HqVCDj8OG4fsEh/+sZZw==
X-Received: by 2002:a7b:c8c6:: with SMTP id f6mr10203634wml.44.1628089116704;
        Wed, 04 Aug 2021 07:58:36 -0700 (PDT)
Received: from localhost ([149.172.45.165])
        by smtp.gmail.com with ESMTPSA id h9sm2551438wmb.35.2021.08.04.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:58:36 -0700 (PDT)
Date:   Wed, 4 Aug 2021 07:58:34 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
Message-ID: <YQqrGvwkf6bJ/5in@archbook>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-3-mdf@kernel.org>
 <YKH/6xQ7bEwJzEsM@kroah.com>
 <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
 <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com>
 <YQPgFn/z024U06HJ@kroah.com>
 <85cd4801-ca1f-4482-6999-3d2e648b24e5@intel.com>
 <YQjY+KL59m51kucV@kroah.com>
 <3ba35b3c-3c85-394b-f404-130968587a6f@intel.com>
 <YQpDySXy0ASM5u9y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQpDySXy0ASM5u9y@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 04, 2021 at 09:37:45AM +0200, Greg KH wrote:
> On Tue, Aug 03, 2021 at 12:02:24PM -0700, Russ Weight wrote:
> > 
> > 
> > On 8/2/21 10:49 PM, Greg KH wrote:
> > >> If the request_firmware() implementation is not acceptable, then would
> > >> you agree that an IOCTL implementation is our best option?
> > > There is no difference in the end between using an ioctl, or a sysfs
> > > file, to provide the filename of your firmware, don't get hung up on
> > > that.
> > 
> > I meant to suggest that passing file data (not a filename) through an
> > IOCTL might be better for this use case than trying to use request_firmware.
> > We have to, somehow, allow the user to point us to the desired image
> > data (which could be a root-entry-hash, or an FPGA image). We can't
> > really use a fixed filename modified by device version as many of
> > the devices do.
> 
> Ah, yes, a "normal" write command might be best for this as that can be
> properly containerized and controlled.
> 
> > > By providing a "filename", you are going around all of the namespace and
> > > other "container" protection that the kernel provides, and allowing
> > > processes to potentially load files that are normally outside of their
> > > scope to the hardware.  If you are willing to allow that security
> > > "escape", wonderful, but you better document the heck out of it and
> > > explain why this is allowed for your special hardware and use case.
> > >
> > > As you are expecting this to work "in the cloud", I do not think that
> > > the operators of such hardware are really going to be all that happy to
> > > see this type of interface given these reasons.
> > >
> > > What is wrong with the current fpga firmware api that somehow is lacking
> > > for your special hardware, that other devices do not have to worry
> > > about?
> > The existing framework wants to update the live image in the FPGA,
> > whereas for this device, we are passing signed data to BMC firmware
> > which will store it in FLASH to be loaded on a subsequent boot of
> > the card.
> > 
> > The existing framework needs to manage FPGA state, whereas for this
> > device, it is just a transfer of signed data. We also have to handle
> > a total transfer/authentication time of up to 45 minutes, so we are
> > using a kernel worker thread for the update.
> > 
> > Perhaps the name, fpga security manager, is wrong? Maybe something
> > like fpga_sec_image_xfer is better?
> 
> It does not sound like this has anything to do with "security", and
> rather is just a normal firmware upload, so "fpga_image_upload()"
> perhaps?

I had originally suggested 'load' and 'persist' or 'load' and 'update or
something of that sort.

Taking one step back, maybe the case could be made for a generic
'persistent firmware' update framework that addresses use-cases that
require updating firmware that may take extended periods of time.

A similar case that comes to mind would be writing firmware to an
external flash on a Renesas xHCI controller, or updating the BMC
firmware for a plug-in card with BMC.

- Moritz
