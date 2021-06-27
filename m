Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0F3B52DD
	for <lists+linux-fpga@lfdr.de>; Sun, 27 Jun 2021 12:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhF0Kus (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 27 Jun 2021 06:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhF0Kus (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 27 Jun 2021 06:50:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0174661C2F;
        Sun, 27 Jun 2021 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624790903;
        bh=wCY04R6LJ1VmCrwpXcJmN4GJv0ptIwAwj+z+JvyrMl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+K3Ku+YD8UDwKqznTE34/tmtp5KmDoBW/2i4aRZn1zkm0YrLSxMDZ+JKvdeTTVyK
         rKSLArQYZnY7hrHgrbrdKBgTxoNDD8rweecRxEfNA86+4TGaYFVAQd6oXYvlpXqvuD
         PtKv1ZkWBx8lL2f1ZUdOL3Y/NREX5abSav1oi928=
Date:   Sun, 27 Jun 2021 12:48:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager late cleanups for 5.14-rc1
Message-ID: <YNhXddymH4BDh2TW@kroah.com>
References: <YNZIhWJGeRwaqRfd@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNZIhWJGeRwaqRfd@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 25, 2021 at 02:20:05PM -0700, Moritz Fischer wrote:
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-cleanup-late-for-5.14

It's too late for 5.14-rc1 if 5.13 comes out today, sorry.  Please add
these to whatever you want me to take after 5.14-rc1 is out.

thanks,

greg k-h
