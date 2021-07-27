Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D763D78A2
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhG0OkN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 10:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhG0OkN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 10:40:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E27A061AF9;
        Tue, 27 Jul 2021 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627396813;
        bh=4hBCz156OMXpekGcTIMuIHns1Ub3KQdK2w5vXakR1tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJdST10xJDsNic7YorR6E7oQhdR82RUpxukOikZDf3UcE+6pSaT0rz94NKCeZVGVg
         zjcQM4J29/NbzPvHC16mdLEhbK7NUInvZWrihtzh5IywnMtxPU5UiBpDTj2K6v7C/+
         9X4EbYWOLraMX7predhPXmzmzpfgXR/yl6mlfC0Y=
Date:   Tue, 27 Jul 2021 16:40:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: versal-fpga: Remove empty functions
Message-ID: <YQAay+5JJf2kTBjo@kroah.com>
References: <20210726030806.714809-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726030806.714809-1-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Jul 25, 2021 at 08:08:06PM -0700, Moritz Fischer wrote:
> Since the core framework now wraps the functions, ensuring
> drives only have to implement functions that do something,
> drop the now no longer required callbacks for state and
> write_complete.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Hi Greg,
> 
> This needs to wait for the earlier pull request [1] that introduces the
> wrapper functions, allowing drivers to drop the empty ones.
> 
> Unfortunately this sort of got of sync with the versal patches getting
> picked up before the wrapper changes went in.

As I said to your pull request, you can now add it to the new request
you will be sending me :)

thanks,

greg k-h
