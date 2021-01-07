Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0192ED415
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jan 2021 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbhAGQNz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Jan 2021 11:13:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbhAGQNz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 7 Jan 2021 11:13:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4F5F22EBF;
        Thu,  7 Jan 2021 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610035995;
        bh=wHGLhgCqicBKL1spOVewqdmUrB/hMDx4rFPyfDRNi4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Roph5+kdVvYz2Wkq+im/V2CC2FlODI4Y6+GLLsISN5WjHUsIIDwgby8IeF0wWp3/8
         6VJz3phpoKTCPL0HVauGbNOS1tHQseGLIRxLXFlvYEn+w3hxQrIuLAi7FoXK3qwUGd
         YQvg1vcGFVhhKp3wL1/6DJRocTaINGpftVPH9uio=
Date:   Thu, 7 Jan 2021 17:14:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, moritzf@google.com
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
Message-ID: <X/czarr9bXr849p5@kroah.com>
References: <20210107043714.991646-1-mdf@kernel.org>
 <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jan 07, 2021 at 08:09:12AM -0800, Tom Rix wrote:
> 
> On 1/6/21 8:37 PM, Moritz Fischer wrote:
> > This is a resend of the previous (unfortunately late) patchset of
> > changes for FPGA DFL.
> 
> Is there something I can do to help ?

This is all now merged in my tree, so there's not much left to do here
:)

thanks,

greg k-h
