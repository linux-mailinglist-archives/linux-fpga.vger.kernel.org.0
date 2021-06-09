Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17A43A1D8C
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhFITSQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 15:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFITSP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 15:18:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E32F613D4;
        Wed,  9 Jun 2021 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623266165;
        bh=4cqLWh1ppp/hZrwvpFtKbyel9fKraZQyl4S5GrUmaVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FA0IuT82Kmgb26c4HTEsXhhtvzA+EzUysDU8lXY0+Kh9VkRo5vsJ8K8o+83kTaSBK
         83h9SUNVw+pEmcWmhu42J42Rq9Loxp1JkA/ihTPv3Wb/CrbSPv27GI+R3J2uRAX1U1
         yRpYkVqhuHlOYypXxehed+CqsD/H0UoDc/OuZ3WY=
Date:   Wed, 9 Jun 2021 21:16:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] fpga: reorganize to subdirs
Message-ID: <YMETcualK2uPMLMc@kroah.com>
References: <20210609142208.3085451-1-trix@redhat.com>
 <YMDV7R52QUTFhpHH@kroah.com>
 <2738ee7a-448f-c327-c430-13fb44da45ec@redhat.com>
 <YMDueTEHGWuAcknP@kroah.com>
 <a35f5fda-a202-dc66-4445-b3ce333a55e6@redhat.com>
 <YMD2yxtsQN16MoPA@kroah.com>
 <aba774cb-1135-26aa-6e20-3c00b4e269ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aba774cb-1135-26aa-6e20-3c00b4e269ac@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 11:52:44AM -0700, Tom Rix wrote:
> > My main complaints here are:
> > 	- these patches were not tested
> > 	- you renamed kernel modules "accidentally"
> > 	- you forgot SPDX lines
> > 	- lack of description of why these files being moved was
> > 	  necessary in the changelog where you moved the files
> > 
> > Remember, patch 0/X never shows up in changelogs...
> 
> I will respin and collapse the patches to a single patch with a better
> commit log.

They should not be a single patch, I never said that at all :(

Please read what I wrote above, did I ever mention there was too many
patches in the series here?

{sigh}

greg k-h
