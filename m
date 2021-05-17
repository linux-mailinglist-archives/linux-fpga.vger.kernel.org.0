Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3703823BA
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 07:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhEQFds (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 May 2021 01:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234141AbhEQFdr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 May 2021 01:33:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC48660FD7;
        Mon, 17 May 2021 05:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621229551;
        bh=dsni+PrR+W3qMxS9Afo/aAW6zjRDZwI/l0wP6mh2yGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loM5mrHgolDsreTbyXfOHkekfWAus5+Yng2KmdkGhNyigJF+HOLFWrLOlm+Q+yzrN
         7SESD8Y8zqV907QjBgLWA1OOdnX0L0lxiyuODLWtIdzzVeAce4pYuhAgzDlKsl8GtU
         46TkIb4ji2GigQ9n/EGKuO54LJ/z7a1so/6vjBmE=
Date:   Mon, 17 May 2021 07:32:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
Message-ID: <YKH/6xQ7bEwJzEsM@kroah.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-3-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517023200.52707-3-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, May 16, 2021 at 07:31:50PM -0700, Moritz Fischer wrote:
> From: Russ Weight <russell.h.weight@intel.com>
> 
> Extend the FPGA Security Manager class driver to
> include an update/filename sysfs node that can be used
> to initiate a secure update.  The filename of a secure
> update file (BMC image, FPGA image, Root Entry Hash image,
> or Code Signing Key cancellation image) can be written to
> this sysfs entry to cause a secure update to occur.

Why is userspace responsible for triggering this?  Passing a "filename"
into the kernel and having it do something with it is ripe for major
problems, please do not.

