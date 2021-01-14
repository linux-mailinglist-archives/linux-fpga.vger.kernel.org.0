Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BDE2F6635
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Jan 2021 17:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbhANQp6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jan 2021 11:45:58 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:36845 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANQp6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 14 Jan 2021 11:45:58 -0500
Received: by mail-pf1-f182.google.com with SMTP id b3so3689936pft.3;
        Thu, 14 Jan 2021 08:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/jWsiQ1w3u/g8oejbHAE82yi0Cw2WGPbx1yC69EielU=;
        b=eaM/iayaQwPX7v7kZ6cjgLIwZJY6DccKtS5nc0yj0EJ5ViFUU1Gd09ZYyn87FCtM3Q
         L1FAd6OeQEqxoa9hHIt1OxP49EZsRcNIh4K21dvl296G62HsOA6ej+eIU/Tv+LJoa75S
         IsAM1WdKBDtbrB5+NzybRGBp3wpwMizXneNqppzxtJ3rQVIxN6wC7Vlz62lNRvmxe1XQ
         Pi0bzenius2eLga0vwB3rge1gpog8zpNDoIvwE6lAIqUd9hprck8FXhMlzX3rPKUewaj
         yRxCV0wfFjtnLa88OeJNKkNKyomYaPI+Xtk7G2pyxJ/PZAGT9w4RIWhwRbyCsWha63+z
         IHYg==
X-Gm-Message-State: AOAM530YigmXazrxswzZk68cIP98j980WQcfO2DUtVUT1BHkCr16WBYW
        AD77LxQVK/kYHFbKfpkOuMs=
X-Google-Smtp-Source: ABdhPJxyEG9pQ7fxWN/pfOiCVS8p+hIRD+x/Ymr7B4pv+077NnbZJfiPyWHn4B+lSMVevKaQU3wnTg==
X-Received: by 2002:a65:4105:: with SMTP id w5mr8426668pgp.52.1610642717606;
        Thu, 14 Jan 2021 08:45:17 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id q16sm5803974pfg.139.2021.01.14.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 08:45:16 -0800 (PST)
Date:   Thu, 14 Jan 2021 08:45:15 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
Message-ID: <YAB1G9e4lCaKq0sq@epycbox.lan>
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
 <X/x0j+hWRdJ6U/MG@kroah.com>
 <CAKXUXMzR2J895_+ZsRqcJ___Pu0HnRfiiFFrGfehQe8J4kQrgg@mail.gmail.com>
 <X/yVflU6ccIlAtgO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/yVflU6ccIlAtgO@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

On Mon, Jan 11, 2021 at 07:14:22PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 11, 2021 at 05:34:57PM +0100, Lukas Bulwahn wrote:
> > On Mon, Jan 11, 2021 at 4:52 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jan 11, 2021 at 12:21:13PM +0100, Lukas Bulwahn wrote:
> > > > Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
> > > > capability") provides documentation to the FPGA Device Feature List (DFL)
> > > > Framework Overview, but introduced new documentation warnings:
> > > >
> > > >   ./Documentation/fpga/dfl.rst:
> > > >     505: WARNING: Title underline too short.
> > > >     523: WARNING: Unexpected indentation.
> > > >     523: WARNING: Blank line required after table.
> > > >     524: WARNING: Block quote ends without a blank line; unexpected unindent.
> > > >
> > > > Rectify ReST formatting in ./Documentation/fpga/dfl.rst.
> > > >
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > >
> > 
> > > You forgot a Reported-by: tag for the person who notified you of this :(
> > 
> > Greg, would you believe that I run 'make htmldocs' on linux-next myself?
> 
> Sure, just seemed to match up with when Stephen reported this a few
> hours earlier...
> 
> thanks,
> 
> greg k-h

Are you waiting for a resend on this? Just asking because we got three
versions of this patch by now :)

I haven't re-sent this since you were already on the thread.

- Moritz
