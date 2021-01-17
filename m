Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99EA2F93A7
	for <lists+linux-fpga@lfdr.de>; Sun, 17 Jan 2021 16:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbhAQPpv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Jan 2021 10:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728700AbhAQPpr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 17 Jan 2021 10:45:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A768A2251F;
        Sun, 17 Jan 2021 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610898307;
        bh=t3zZcca4zIt6z+nrt4nmiIyB8hCcHff/IjNUqqEK1Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1vpgxM/fA2X7wQwKNpj3U12JWlBiCNTFJBfI1KKGzNa5akhAqL+NDAZfzx8VOjKzY
         Pnm6Ej5+gzBmdX8XkjZa4j8nGfwku5yfRNjqGcXY9BwMU9CEKM0Q+rz/r6ruvsxEn6
         PVRVHefdo8eg6wmZU9QVEJoFtRdGxI6SNGITVaEY=
Date:   Sun, 17 Jan 2021 16:45:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com
Subject: Re: [PATCH v6 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
Message-ID: <YARbgGU6lr3zZaKP@kroah.com>
References: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
 <1610502848-30345-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610502848-30345-2-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jan 13, 2021 at 09:54:07AM +0800, Xu Yilun wrote:
> This patch supports the DFL drivers be written in userspace. This is
> realized by exposing the userspace I/O device interfaces.
> 
> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
> platform device with the DFL device's resources, and let the generic UIO
> platform device driver provide support to userspace access to kernel
> interrupts and memory locations.

Why doesn't the existing uio driver work for this, why do you need a new
one?

> ---
>  drivers/fpga/Kconfig        | 10 +++++
>  drivers/fpga/Makefile       |  1 +
>  drivers/fpga/dfl-uio-pdev.c | 93 +++++++++++++++++++++++++++++++++++++++++++++

uio drivers traditionally go in drivers/uio/ and start with "uio", so
shouldn't this be drivers/uio/uio_dfl_pdev.c to match the same naming
scheme?

But again, you need to explain in detail, why the existing uio driver
doesn't work properly, or why you can't just add a few lines to an
existing one.

thanks,

greg k-h
