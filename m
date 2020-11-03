Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982782A3CD6
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 07:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCGc5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 01:32:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgKCGc5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Nov 2020 01:32:57 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604EE22277;
        Tue,  3 Nov 2020 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604385177;
        bh=prlYMCOPzVKAoMPhqQ/ioMFuXisq6TdbMhQECzJEdWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f49CFq/2xpmz2gKsiJ4GOMwCQUSZCfXalxtW+WO3uNOPOj9bDrr46FZ+DScNQNf2V
         183x1XPWb9PAbDAPtQgReLx43CF92p1xEr7P6EQkQRdp3E5mxNAykxE3RkEOm0eyZc
         i5wNfkW+BYa+nFj1+qjEbylrzrcRQbYC88REK3GY=
Date:   Tue, 3 Nov 2020 07:32:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com
Subject: Re: [GIT PULL] FPGA DFL Modularization changes for 5.11
Message-ID: <20201103063253.GA74163@kroah.com>
References: <20201103015028.GA3548@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103015028.GA3548@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Nov 02, 2020 at 05:50:28PM -0800, Moritz Fischer wrote:
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> 
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/dfl-modularization-for-5.11

Given my "issues" that I have had with this series in the past, can you
send this as patches so I can properly review them and apply them if all
is ok instead?

thanks,

greg k-h
