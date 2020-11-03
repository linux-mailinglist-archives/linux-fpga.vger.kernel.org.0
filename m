Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446A12A3CEB
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 07:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCGlL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 01:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbgKCGlK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Nov 2020 01:41:10 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E0522277;
        Tue,  3 Nov 2020 06:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604385670;
        bh=N3oWIEprPTARppPAU8sBhCNatONuCluO8qn8F3xCFc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMPkWUXJ90TSEJv9aB/cjEoVR5ee/mAp5/c7izf+2CMHHTqeU1l4r2pOhdWc6p0AH
         kViTNMXHGz2CMUKs2zFrvXoP6bMgliKyTzXq0VP5IQss/Bk8xiq3a8krVEDpaMri0d
         E8yfDEYW0RUBC1EVR7mO4zaxfEF4CtkPd9KSpPx0=
Date:   Tue, 3 Nov 2020 07:41:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, trix@redhat.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager changes for 5.11
Message-ID: <20201103064106.GA75324@kroah.com>
References: <20201103021221.GA4952@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103021221.GA4952@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Nov 02, 2020 at 06:12:21PM -0800, Moritz Fischer wrote:
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> 
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ fpga-mgr-cleanup-for-5.11

Same for here, can you just send patches?

thanks,

greg k-h
