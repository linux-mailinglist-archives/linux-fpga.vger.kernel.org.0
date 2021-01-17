Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4752F93F6
	for <lists+linux-fpga@lfdr.de>; Sun, 17 Jan 2021 17:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbhAQQXW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Jan 2021 11:23:22 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:46940 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbhAQQXV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Jan 2021 11:23:21 -0500
Received: by mail-pl1-f176.google.com with SMTP id u11so2990873plg.13;
        Sun, 17 Jan 2021 08:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VvDskUcTMKO/Knbyega3fwW2CY3W1m4PF63C8ZG/0S4=;
        b=ZZxC3bW8Ce24IHmxgjFgux53r7w+C1Tnay8DnfKifqH87+DiVWmfsO6BbMyjo6fuJ5
         F/4MZ3cpVx8xrS1/LIydSM5JRNx0FUIb4akpxhd9zP/6p7+/WmS7Vx8/g5SiHYylHs72
         Rr1EQgt355ftXTO0YCVNk1gFfuwAdTuCs/BgeP3ABNuB2YYJtsx/xVuHM/BTtZzNQvIU
         6VXygFBihSwy3DM93USe4t4P3asLH0V5LokbMN07K2NRKuOQYNAIhqCPUTleGYRFPOR8
         Za7lRk/FzLh/Mea7PYUYqR2ttxe3cYd9SQIK3eJ6YktU0Ml/kvw+JIBveK0fUAFPPYnQ
         4Pzw==
X-Gm-Message-State: AOAM532qwaywavzMJeciStnq2vsO2mr9/IKhAaDvXR7ybPqSkpT0Yr+b
        Vo7ZDaA1gxFymYOxd4gyV/A=
X-Google-Smtp-Source: ABdhPJzgGqtPs3rM2Y5e0plUZL+BL2vEnRwxkNpNHrNOAkhUK9Rp0iKEmnLvPNoYm5UTyatdzWVxWg==
X-Received: by 2002:a17:90a:d494:: with SMTP id s20mr22023049pju.178.1610900558700;
        Sun, 17 Jan 2021 08:22:38 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 73sm13988656pga.26.2021.01.17.08.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 08:22:37 -0800 (PST)
Date:   Sun, 17 Jan 2021 08:22:36 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v6 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
Message-ID: <YARkTFMrotPo45ic@epycbox.lan>
References: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
 <1610502848-30345-2-git-send-email-yilun.xu@intel.com>
 <YARbgGU6lr3zZaKP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YARbgGU6lr3zZaKP@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Greg,

On Sun, Jan 17, 2021 at 04:45:04PM +0100, Greg KH wrote:
> On Wed, Jan 13, 2021 at 09:54:07AM +0800, Xu Yilun wrote:
> > This patch supports the DFL drivers be written in userspace. This is
> > realized by exposing the userspace I/O device interfaces.
> > 
> > The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
> > platform device with the DFL device's resources, and let the generic UIO
> > platform device driver provide support to userspace access to kernel
> > interrupts and memory locations.
> 
> Why doesn't the existing uio driver work for this, why do you need a new
> one?
> 
> > ---
> >  drivers/fpga/Kconfig        | 10 +++++
> >  drivers/fpga/Makefile       |  1 +
> >  drivers/fpga/dfl-uio-pdev.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
> 
> uio drivers traditionally go in drivers/uio/ and start with "uio", so
> shouldn't this be drivers/uio/uio_dfl_pdev.c to match the same naming
> scheme?

I had considered suggesting that, but ultimately this driver only
creates a 'uio_pdrv_genirq' platform device, so it didn't seem like a
good fit.
> 
> But again, you need to explain in detail, why the existing uio driver
> doesn't work properly, or why you can't just add a few lines to an
> existing one.

Ultimately there are three options I see:
1) Do what Xu does, which is re-use the 'uio_pdrv_genirq' uio driver by
  creating a platform device for it as sub-device of the dfl device that
  we bind to uio_pdrv_genirq
2) Add a module_dfl_driver part to drivers/uio/uio_pdrv_genirq.c and
  corresponding id table
3) Create a new uio_dfl_genirq kind of driver that uses the dfl bus and
  that would make sense to then put into drivers/uio. (This would
  duplicate code in uio_pdrv_genirq to some extend)

Overall I think in terms of code re-use I think Xu's choice might be
less new code as it simply wraps the uio platform device driver, and
allows for defining the resources passed to the UIO driver to be defined
by hardware through a DFL.

I've seen the pattern that Xu proposed used in other places like the
macb network driver where you'd have macb_main (the platform driver) and
macb_pci that wraps it for a pci usage.

- Moritz
