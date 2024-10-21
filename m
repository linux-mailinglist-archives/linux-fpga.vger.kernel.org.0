Return-Path: <linux-fpga+bounces-794-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125A9A6A03
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Oct 2024 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A3F1C22953
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Oct 2024 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253411F1311;
	Mon, 21 Oct 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8m/3G3w"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC081EC01E;
	Mon, 21 Oct 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517004; cv=none; b=szgJMjtlJAbn+PIBacNQASdPCVLuXdizmMkXyKdoJX8Gkj9gXUdt8/SjFYItSZ8vKELkTWnf9g2sA72JsHsRG3Fk98iqfysNWQcD597pfgOWFQMaSzQYLY2uOmb707tIni13HiranCNcn6Swbe+m0iz3QC5g1tONkPfKfrSnGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517004; c=relaxed/simple;
	bh=KrIr5TD/tMCRzHcZXtOxV67jdslZZdFURr5RzMBftas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dV+N1V9sPWXIIe2ogDEGyLFA3/uirFtc5jm1xw3pbc2abOxS0InK4pZVt9dJ4a0tBLiBShX9SypAwhvw1pBeHYOfqbqJCw43maYbS50tebb6R7aTGLp9YWHlV0eelLYCIjykVNQeLV/avDnRUCdcCa34LEILget9JgicGR+OOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8m/3G3w; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so4195776276.2;
        Mon, 21 Oct 2024 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517001; x=1730121801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oiaj5vEk58Uu7Q5W05B/+5MSwPTnerZpSh0c5/iJqpY=;
        b=d8m/3G3wYWcgTl3ZOtKGJRNTecT1o9t7vYm25n4a5qk6SZrknuv3e2DoqPq3Z+rT83
         doGB7vd9NAaSAr5RaSVKBT1L/zzysqEo09ZKFvpV7f80pTzqIekMZoT3c91+6DCxBxcw
         6VYQkHMcHE3yKBDCMlJ+y8ATLjcjaqTQBrOM4KfR7iwMNW5a7lMHCfIOFYFJkJLKVfDT
         DrhJKPViuWEgoU8DsHtDKIbmGDrUuQ3Sds360aH42ciWP08nDn7eVVZJQYiWRHIQFP2L
         B8Xe1TikgD0EmrbrEDxiUafXWCkFClwZT8HVkeOT1FMDlGuGOtvMgloeq7CBZ49E0Hdr
         oXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517001; x=1730121801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiaj5vEk58Uu7Q5W05B/+5MSwPTnerZpSh0c5/iJqpY=;
        b=OOCoQqILddpvmq+9G5a0m6rLSIAwCC6wY4zihB7Q5zYQBkwEwU3LYFaB6nEmJQboG5
         1Q6xYMztTh3h9uTRqyYkUydOR+GJAzO1/Wqrk/TRPwWfuPQ4UeqIaBTS+YIQT6i8rbza
         aiS4QE56kHFqhCiAdATiUVj9WxW1L+7hhMjHbJePg13BgliihRu0qC3ZJFVEdXQ98Xhh
         QfaNkL5iMBwohVD93rRDlVJVeD+nZDd7MwI9qLfOAtmwcJt0lfFpRpVaUQ+Du1kuoVEW
         39iwWSF56WxqVsJqKNdDaJHfb+z+ghH0gTUXZE0jN7hWluxqBSrGuhIAHMkpQMN6cGSL
         oG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyvxlpC07gnJd94Od21KVDEACoAJS8Y5kKqFrh4Qmsn83hYPTILS9kSLrQUPktz8RshjWahvG+Yalt@vger.kernel.org, AJvYcCWV8MmVJEZsVv4DZYmiu7ShzG2FLw5ZmKiqOFRmFwOwXrh0qbJ/wuqS07L/aAInRLOqX1ZkxluNFuXstz7T@vger.kernel.org, AJvYcCXD4KQH99FAreqloAYgYpdq64y4giFN0qHM29OP0PNW4lwboJYcYaL0L4SrTox6ssM4WtQcxGmJTjwTRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdCXA2/do6/OZXSAcP/noK4ChpSphc2h9jdLlDRks4Gd7pButC
	V595dkdRWtp0XSBYBqREPK/7gY2SHe1QlEQ98VfRbTt52WENEqU9eTPKHTl7L/0dsXo67VCuYvu
	iYlg0JaBEO0PP6YO9Mp7JH4MsXgM=
X-Google-Smtp-Source: AGHT+IHlUOxt1/NRsWxzoxhFmYbXmB0LFOgRabrM0r/vzuOswt5ukRgoBSsCDgfnHkH8z3V9ZTIavsl/lv43Z+c290U=
X-Received: by 2002:a25:d681:0:b0:e2b:d3da:46d7 with SMTP id
 3f1490d57ef6-e2bd3da4803mr4186272276.40.1729517000949; Mon, 21 Oct 2024
 06:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <ZxG70kzjsvT3UBlQ@yilunxu-OptiPlex-7050> <20241018-chump-juvenile-dc368d3d2f2c@spud>
 <ZxW4DJOES77ifOC9@yilunxu-OptiPlex-7050> <20241021-depravity-scale-6123da541538@spud>
In-Reply-To: <20241021-depravity-scale-6123da541538@spud>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Mon, 21 Oct 2024 15:23:10 +0200
Message-ID: <CAKrir7gB+cdnHJu6ZgpEOA-rYLpVK0wJOG=9zChmA6fMCyZRQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fpga: Add Efinix Trion & Titanium serial SPI
 programming driver
To: Conor Dooley <conor@kernel.org>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, mdf@kernel.org, hao.wu@intel.com, 
	yilun.xu@intel.com, trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, neil.armstrong@linaro.org, heiko.stuebner@cherry.de, 
	rafal@milecki.pl, linus.walleij@linaro.org, linux-fpga@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 21. Okt. 2024 um 14:18 Uhr schrieb Conor Dooley <conor@kernel.org>:
>
> On Mon, Oct 21, 2024 at 10:10:20AM +0800, Xu Yilun wrote:
> > On Fri, Oct 18, 2024 at 05:58:44PM +0100, Conor Dooley wrote:
> > > On Fri, Oct 18, 2024 at 09:37:22AM +0800, Xu Yilun wrote:
> > > > On Fri, Sep 27, 2024 at 04:14:42PM +0200, iansdannapel@gmail.com wrote:
> > > > > From: Ian Dannapel <iansdannapel@gmail.com>
> > > > >
> > > > > Add a new driver for loading binary firmware to volatile
> > > > > configuration RAM using "SPI passive programming" on Efinix FPGAs.
> > > > >
> > > > > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > > > > ---
> > > > >  drivers/fpga/Kconfig                    |  10 ++
> > > > >  drivers/fpga/Makefile                   |   1 +
> > > > >  drivers/fpga/efinix-trion-spi-passive.c | 211 ++++++++++++++++++++++++
> > > > >  3 files changed, 222 insertions(+)
> > > > >  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> > > > >
> > > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > > index 37b35f58f0df..eb1e44c4e3e0 100644
> > > > > --- a/drivers/fpga/Kconfig
> > > > > +++ b/drivers/fpga/Kconfig
> > > > > @@ -83,6 +83,16 @@ config FPGA_MGR_XILINX_SPI
> > > > >           FPGA manager driver support for Xilinx FPGA configuration
> > > > >           over slave serial interface.
> > > > >
> > > > > +config FPGA_MGR_EFINIX_SPI
> > > > > +       tristate "Efinix FPGA configuration over SPI passive"
> > > > > +       depends on SPI
> > > > > +       help
> > > > > +         This option enables support for the FPGA manager driver to
> > > > > +         configure Efinix Trion and Titanium Series FPGAs over SPI
> > > > > +         using passive serial mode.
> > > > > +         Warning: Do not activate this if there are other SPI devices
> > > > > +         on the same bus as it might interfere with the transmission.
> > > >
> > > > Sorry, this won't work. As you can see, the conflict usage of CS causes
> > > > several concerns. Just a text here is far from enough.
> > > >
> > > > You need to actively work with SPI core/controller drivers to find a
> > > > solution that coordinate the usage of this pin.
> > >
> > > Why does it even impact other SPI devices on the bus? It's not /their/
> > > CS line that is being modified here, it is the line for the FPGA's
> > > programming interface, right?
> > > What am I missing here that makes it any different to any other SPI
> > > device that may need it's CS toggled?
> >
> > IIUC, now spi core or controller driver should fully responsible for
> > HW operations of CS. And every good behaved spi device driver should
> > declare their logical CS index defined by SPI controller and let SPI
> > core/controller driver to proxy the CS change.
> >
> > But if this spi device driver directly aquires CS, it conflicts with
> > the controller and just fails.
>
> Right, I don't think you answered my question here at all, but just
> reading over the kconfig text again I think I understand what it means.
> I'd interpreted this as other devices being impacted by what this driver
> is doing, but actually it is talking about other devices on the bus
> interfering with this one because of how it handles the chip select.

Correct, the problem lies when other devices initiate a transfer in
between the device programming:
If the CS goes inactive in between, the fpga won't be programmed
correctly since it requires that all bytes are transferred within the
same CS active.
If the CS remains active, the fpga will be programmed with random payloads.

But I might have found a solution to coordinate the CS with the
controller (set_cs in struct spi_controller), since the cs state must
be set before any transfer to enter the programming mode.

Regards,
Ian

