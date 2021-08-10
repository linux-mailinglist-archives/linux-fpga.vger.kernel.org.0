Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD13E7DF4
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Aug 2021 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhHJRGe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Aug 2021 13:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhHJRGe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 10 Aug 2021 13:06:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ABD5600EF;
        Tue, 10 Aug 2021 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628615171;
        bh=v/Z8K0cHbxfW2UPujBeHKC6ZbgjyhWPVFh7X3HNJV1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U29ntLO8FtULlDO7gwSA+D9Ie2n/jNPsD2Ppc+6LT7sh/LQv0o04IZ3+xN/AxkaKf
         18EXHB+Se6fbrxv1lyPojROhEdOOOvUzNvZYIsudGsoNCRKz8qFBCDMPlAvhXqhpO3
         cwS8fGPo2v+KviYLmUz9diBmdwQzgAOw15rmdFaw=
Date:   Tue, 10 Aug 2021 19:06:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, p.pisati@gmail.com, atull@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] fpga: machxo2-spi: return an error on failure
Message-ID: <YRKyAScLKow17mPO@kroah.com>
References: <20210810164036.922830-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810164036.922830-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Aug 10, 2021 at 09:40:36AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Reported problem
> 
> 	drivers/fpga/machxo2-spi.c:229 machxo2_write_init()
> 	warn: missing error code 'ret'
> 
> 	drivers/fpga/machxo2-spi.c:316 machxo2_write_complete()
> 	warn: missing error code 'ret'

What reported this?  What does it mean?  Where was it reported?

please be specific...

thanks,

greg k-h
