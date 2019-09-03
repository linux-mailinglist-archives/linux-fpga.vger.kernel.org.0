Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0870A741B
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Sep 2019 21:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfICT6k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Sep 2019 15:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfICT6j (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Sep 2019 15:58:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC90121881;
        Tue,  3 Sep 2019 19:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567540719;
        bh=QLeqPeOj3bhN7SZ4cnbMOlwNo26KWq2LDlLgwOEB0Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/92znQ8/5T+0dNaCmEN5wcep2pqccNjqfXL/3mmR/YNszIboi/NjakBZidWv9LYr
         xc3HLLxFi0zxHeinDymI1NolI5/+exKgfRmEjrRNWfh+GCr4taeZYcgU3bH//bG7Ae
         R/v7gG5DYl6peyFu1fn9UF77Ut0YpbjgCL8ROrFg=
Date:   Tue, 3 Sep 2019 21:58:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] Please pull FPGA Manager changes for 5.4
Message-ID: <20190903195824.GE13390@kroah.com>
References: <20190831204528.GA23936@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831204528.GA23936@archbox>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Aug 31, 2019 at 01:45:28PM -0700, Moritz Fischer wrote:
> The following changes since commit 2949dc443116a66fd1a92d9ef107be16cdd197cd:
> 
>   dt-bindings: fpga: Consolidate bridge properties (2019-07-24 14:19:15 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-cvp-for-5.4

Pulled and pushed out, thanks.

greg k-h
