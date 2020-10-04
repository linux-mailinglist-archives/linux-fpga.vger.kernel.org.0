Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8750B282DA4
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 23:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJDVBJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 17:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgJDVBH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 17:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601845266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J20BiFc6m3RHcFdesFRsBwhx7Lh/GICUTgu5OMkGdFI=;
        b=e0cDU+lAR6mViF0XHx+HKVj+Dtxg8PUAzWXlUdpyNLEASOugjx71tfH2bDZcgTQYYXOkO6
        tgN1AbBJXDOoSSSKEsrkmTQfsYOf74cyE1ICyZqjOTI/GNze9g/IBM1jNGqe8RXJSuCD2W
        Ep8TrUEMcJMKqlnt0RIUKNSZlnJQQLI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-v7WkaQxGOmifotkWgI1EXw-1; Sun, 04 Oct 2020 17:01:03 -0400
X-MC-Unique: v7WkaQxGOmifotkWgI1EXw-1
Received: by mail-qt1-f198.google.com with SMTP id l12so1671994qtu.22
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 14:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J20BiFc6m3RHcFdesFRsBwhx7Lh/GICUTgu5OMkGdFI=;
        b=opSg4AIXJ2jVOjF7QW39AdIAOvFpDWnq5gByX2oiwBqYJIOChOJpuKzydINPDQRIKy
         Yf5+d5JbEIzSU2Df5iT+2v9FZK0jHF+jBjz2qXc332/zzM3nhrRvIBxRtBpqiVYzwptl
         NKuvM1E8SHkkeJnIZGe+YteuRwMM9Xh+vR1Gsjt4kDDJuGNm8iOx7SV8or/nDq50919T
         g4W4Cy6MTwrMCsEEjItfiwmWCzf9cObq25YnnGkyprNR8LAU2nlfpsOAcYybmtJbxeC0
         jQKk71+VMw7eWrt/Kz+d1aAj377g2b1Di3jOZuCW77n+iDA9O/kha+SGA7VGhBQmm3Zu
         GAEg==
X-Gm-Message-State: AOAM533dHpKtUBy35lObEKF15F8GRtJipY7svF+ONgHexx8rxT8IIZHB
        nFoT+3Xpxg2PzJTlX6vIaNYuHhnYojG2Dt2rRUxVDD5ThVi72D5gYiIv+b/zWZ3MtthsqB8fkNU
        G6xPxfOP5SK1k7KKlZA+rjA==
X-Received: by 2002:a37:a781:: with SMTP id q123mr11774910qke.436.1601845262554;
        Sun, 04 Oct 2020 14:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNC0a6jG7B0KHTvPPbYripQO92zGYHKX73STLYgV86g8TeaQOP4sV5T+Rijk9WqQfead8nZw==
X-Received: by 2002:a37:a781:: with SMTP id q123mr11774890qke.436.1601845262322;
        Sun, 04 Oct 2020 14:01:02 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q7sm3632843qtd.49.2020.10.04.14.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 14:01:01 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] fpga: sec-mgr: expose sec-mgr update status
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-4-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ee0408f4-fef4-53b9-1e64-76e2a6b634d5@redhat.com>
Date:   Sun, 4 Oct 2020 14:00:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201002223701.1317-4-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/2/20 3:36 PM, Russ Weight wrote:
> Extend the Intel Security Manager class driver to
> include an update/status sysfs node that can be polled
> and read to monitor the progress of an ongoing secure
> update. Sysfs_notify() is used to signal transitions
> between different phases of the update process.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Bumped documentation date and version
>   - Changed progress state "read_file" to "reading"
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 11 +++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 40 +++++++++++++++++--
>  2 files changed, 47 insertions(+), 4 deletions(-)

This was 07/12 in the old patchset.

Also looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


