Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD6268734
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Sep 2020 10:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgINI2S (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 04:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgINI2S (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Sep 2020 04:28:18 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E8A7221E8;
        Mon, 14 Sep 2020 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600072098;
        bh=+C90skCjKrIs419+Z0xUPJVzzlswXflLWDVw7gynC/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UaIx53tZYFfVSBvmrsXhNkXH+w4VJHo8F+lpT9WFE9VTooSCfdHD3NtElyHdBMWnF
         Fgo56loon8ikSFaBSxbkE4ChVAADquks50qLdJ7PZhcewf6/CmiKf/AO7l9is1hYyZ
         +juKt8Nrj8wVGgkdn1uNTcxvbHm1ou6qyWum5dM4=
Date:   Mon, 14 Sep 2020 10:28:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager changes for 5.10
Message-ID: <20200914082807.GA1930090@kroah.com>
References: <20200913225526.GA52103@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913225526.GA52103@epycbox.lan>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Sep 13, 2020 at 03:55:26PM -0700, Moritz Fischer wrote:
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> 
>   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.10

Pulled and pushed out, thanks.

Nice work on the bus code as well, looks clean.

greg k-h
