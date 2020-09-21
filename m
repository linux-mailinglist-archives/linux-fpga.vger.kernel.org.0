Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DC3273394
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Sep 2020 22:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIUUbG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Sep 2020 16:31:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44417 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgIUUbG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Sep 2020 16:31:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7so10013808pgm.11;
        Mon, 21 Sep 2020 13:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P0uToVl4KeI0/z8GhakX1flZZCU/iEccTg0V560uDl8=;
        b=AP1yrcT/AzEY2sSHfCanZpKU82+82DxzNnkSKyaFCueuSt/nilPAzAhoWYUZNmq6n6
         KmnB5dQ4QuLZub/1Egi9oX1lWKA/8w+Lg6XrCPhF4NCq676zm4sO4yfGqv5DMA6ti1i4
         y+nINzJT4zLpjPj5eVHOuZMhn+qDWBIRxjV/I5vS77sfDfZ+asn03qJynrLdQ5a1X3ZZ
         1zsMu1GUh2JKRkYHkoWc13ONwafJYDMKLcZOY6rCVuKmrMqPqQ+feotk0ROXqHwVTVJN
         zZJfZn2jnkumpbWb4Exm5L7YKKAAEKmGqdvaQO+LTY7k5nBYSU5L4vaKmScj6w60OyX7
         kNNQ==
X-Gm-Message-State: AOAM533ONpB1GU+EUCJ3sisucRW/cE7cxND97QkjEVmIBcrSaN27Enlb
        T+s7yN561VfnF29CyTRdMhcr6esECag=
X-Google-Smtp-Source: ABdhPJwPlYP+S57zL8GzVGE2tS6Y3Za3ZWzcF4J9r32UfjNjWLGCNyIHnMYY/1ez16BADigg3K0J9g==
X-Received: by 2002:a17:902:b117:b029:d1:e5e7:bdf5 with SMTP id q23-20020a170902b117b02900d1e5e7bdf5mr1437600plr.85.1600720265605;
        Mon, 21 Sep 2020 13:31:05 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u14sm12654099pfm.80.2020.09.21.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:31:05 -0700 (PDT)
Date:   Mon, 21 Sep 2020 13:31:04 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v3] memory: dfl-emif: add the DFL EMIF private feature
 driver
Message-ID: <20200921203104.GA35580@epycbox.lan>
References: <1600666280-25651-1-git-send-email-yilun.xu@intel.com>
 <1600666280-25651-2-git-send-email-yilun.xu@intel.com>
 <20200921072311.GA6133@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921072311.GA6133@kozik-lap>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Krzysztof,

On Mon, Sep 21, 2020 at 09:23:11AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Sep 21, 2020 at 01:31:20PM +0800, Xu Yilun wrote:
> > This driver is for the EMIF private feature implemented under FPGA
> > Device Feature List (DFL) framework. It is used to expose memory
> > interface status information as well as memory clearing control.
> > 
> > The purpose of memory clearing block is to zero out all private memory
> > when FPGA is to be reprogrammed. This gives users a reliable method to
> > prevent potential data leakage.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> > v2: Adjust the position of this driver in Kconfig.
> >     Improves the name of the Kconfig option.
> >     Change the include dfl-bus.h to dfl.h, cause the previous patchset
> >      renames the file.
> >     Some minor fixes and comment improvement.
> > v3: Adjust the position of the driver in Makefile.
> > ---
> >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> >  drivers/memory/Kconfig                             |   9 +
> >  drivers/memory/Makefile                            |   2 +
> >  drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
> >  4 files changed, 243 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> >  create mode 100644 drivers/memory/dfl-emif.c
> > 
> 
> Hi Moritz,
> 
> Since this depends on dfl patches, I would need a stable tag with them
> or you can take it directly:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof

The FPGA patches go through Greg's tree. For the time being it's
probably easiest if I take the changes through my tree once Greg pulled
my tree.

Do you have any feedback to better handle this sort of subsystem
spanning changesets for me?

Thanks,
Moritz
