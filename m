Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD14222EEE
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jul 2020 01:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGPXVM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Jul 2020 19:21:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53620 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgGPXVM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Jul 2020 19:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594941670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TIFp0Hg7q04yf1DG6HMd9RGoWeHArzTBdvRZoWQamlI=;
        b=hCGVvcIre/CjWo3XxIJPjVMYASQcrd0OsDHXXySjOMJRh7rlA0lur87bvtu+OPBSVhFm5X
        J8WDm/fqJ9ClxVaxluQcNrogJgrD5hKvA6tRdITveeFMjtVnVKAblIa2G0nRDF0Pzau+WE
        TTayuhmqvPC0MOkduM4pCsdb7t1nGwo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-mDZ43DRzP0mmN6o7kX8u_g-1; Thu, 16 Jul 2020 18:50:55 -0400
X-MC-Unique: mDZ43DRzP0mmN6o7kX8u_g-1
Received: by mail-qv1-f71.google.com with SMTP id g17so4413695qvw.0
        for <linux-fpga@vger.kernel.org>; Thu, 16 Jul 2020 15:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TIFp0Hg7q04yf1DG6HMd9RGoWeHArzTBdvRZoWQamlI=;
        b=Ij6FdsXTkV2+2QrU3C9qD9BjdgR7BuT4/DrDASvaVyP+LtxGLUtHJWyuuMAaVDg8Ht
         hcB+h7L/3rq+i9nNL2swxy6gOLsUo7PhZQvizkyTVpbNiPvfxzzxi+G/cgIHGj5W+5Yo
         JInTQMOtuiM1prXOH++VPQEluMdBKepkqNya06MRE+wwHk8S1jVhrrMzCg9j17+5j/RU
         W3nbhj1XAS+XopjK9LNJWdTFHwtVY1M7aubLEh/hFR+Q0nhIh1AuZR31J5VMRbMQdY2k
         FC+BtX04P4gu9B11c3hcKu4u025MNvtRZ99q20xF7e7eXDP5e7n80rBc5M+jxs/H81bU
         YWfA==
X-Gm-Message-State: AOAM530CKIfTJDVSnBHsk6KPyFeygrS4xGFMeN4UQCk8Umq0z6egZOnI
        n2ZZleg9jLttccap3kjBPwoufAXKrCkXHx5aolQbIFxhec8mxFeE179H0nAD4Nihfp7AgIWygkF
        lqKzfoPk4c01UtuR1MjTNBg==
X-Received: by 2002:a37:6343:: with SMTP id x64mr6351695qkb.114.1594939854044;
        Thu, 16 Jul 2020 15:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9I+YtgVZqYJkdYGFK6gqcCdhQADDw6d3C/sjWjsOMDp/j86RqH2uKqe6zw6lUnjp2cIPBRg==
X-Received: by 2002:a37:6343:: with SMTP id x64mr6351678qkb.114.1594939853688;
        Thu, 16 Jul 2020 15:50:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a6sm8439003qkd.69.2020.07.16.15.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 15:50:52 -0700 (PDT)
Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
Date:   Thu, 16 Jul 2020 15:50:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Generally i think this is a good approach.

However I do have concern.

The feature_id in dfl is magic number, similar to pci id but without a vendor id.

Is it possible to add something like a vendor id so different vendors would not have to be so careful to use a unique id ?

This touches some of the matching function of the bus ops.  Could there be a way for bus ops to be used so that there could be multiple matching function.  Maybe the one in 0002 as a default so users could override it ?

The use case I am worrying about is an OEM.  The OEM uses an unclaimed feature_id and supplies their own platform device device driver to match the feature_id.  But some later version of the kernel claims this feature_id and the OEM's driver no longer works and since the value comes from pci config space it is difficult to change.

So looking for something like

register_feature_matcher((*bus_match)(struct device *dev, struct device_driver *drv))

static int dfl_bus_match_default(struct device *dev, struct device_driver *drv)
{
    struct dfl_device *dfl_dev = to_dfl_dev(dev);
    struct dfl_driver *dfl_drv = to_dfl_drv(drv);
    const struct dfl_device_id *id_entry = dfl_drv->id_table;

    while (id_entry->feature_id) {
        if (dfl_match_one_device(id_entry, dfl_dev)) {
            dfl_dev->id_entry = id_entry;
            return 1;
        }
        id_entry++;
    }

    return 0;
}

register_feature_matcher(&dfl_bus_match_default)

static int dfl_bus_match(struct device *dev, struct device_driver *drv)
{

    struct dfl_device *dfl_dev = to_dfl_dev(dev);
    struct dfl_driver *dfl_drv = to_dfl_drv(drv);
    const struct dfl_device_id *id_entry = dfl_drv->id_table;

    while (id_entry->feature_id) {

        matcher = Loop over matchers()

        if (matcher(dev, drv)) {
            dfl_dev->id_entry = id_entry;
            return 1;
        }
        id_entry++;
    }

    return 0;
}

Or maybe use some of the unused bits in the dfl header to add a second vendor-like id and change existing matcher to look feature_id and vendor_like_id.

Tom

 

On 7/14/20 10:38 PM, Xu Yilun wrote:
> This patchset makes it possible to develop independent driver modules
> for DFL private features. It also helps to leverage existing kernel
> drivers to enable some IP blocks in DFL.
>
> Xu Yilun (2):
>   fpga: dfl: map feature mmio resources in their own feature drivers
>   fpga: dfl: create a dfl bus type to support DFL devices
>
>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>  drivers/fpga/dfl-pci.c                  |  21 +-
>  drivers/fpga/dfl.c                      | 435 +++++++++++++++++++++++++++-----
>  drivers/fpga/dfl.h                      |  91 ++++++-
>  4 files changed, 492 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>

