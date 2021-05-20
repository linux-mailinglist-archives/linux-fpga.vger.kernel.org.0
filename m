Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D0E38B1D4
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 16:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhETOiX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 10:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232781AbhETOiU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 10:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621521418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3QdhlEV0blTi2w4VmxO9VckI70luGlKI3gtS3llsuU=;
        b=a4/l/o5kwZvN4vtSBbtHE6Q3WOERkKGn556gHgiSG6PGBVXLZD2O2PdGtuCkw9qX7pp5Id
        h9WmDT3+Fhp78WkA3MkvTkzB4s4eYQE62AAn0jGx+Lf1POXk0gdC2TilEvVAwb3mSBXknE
        bfN03SH1h/SYFd6VfdIqi6HMJ/rucTQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-ltT8sxhtP2S7DeHDe1wwMw-1; Thu, 20 May 2021 10:36:56 -0400
X-MC-Unique: ltT8sxhtP2S7DeHDe1wwMw-1
Received: by mail-qk1-f198.google.com with SMTP id a198-20020a3766cf0000b0290320e7711ebdso12605894qkc.22
        for <linux-fpga@vger.kernel.org>; Thu, 20 May 2021 07:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L3QdhlEV0blTi2w4VmxO9VckI70luGlKI3gtS3llsuU=;
        b=JtS4ME+ytEYnaagF7XAww10QMzDpo9CzwesFm/HABX6K8Vg3MLPt0lGuztencvF1FT
         QlHRbOP0VXcEusIX/TeVNSBMgqp0NLahlx/axWMRgZW8YohsdDt7YmbZxVC2A1h1Y9mq
         pD6OyEAdpzYdHCPIVvJ8vHZzwQn6+SrnA5oW8cio7by8pSyW3MdRf8x7HIgxwGj5PWRh
         khuQFS4oVXhKpCmuA9Qi8ZGX9IQl0b9acsvBGMWanAsXUcAdSDbNiZZkiafPfq9CqL3X
         qLr46PqLXzXEqK2ERVct8nDK2687m3W9/qPpegwM2TnTQcUO7q7ROllaic+aCt0bo8ee
         SZrA==
X-Gm-Message-State: AOAM532Y5Sw+3ENDtuyzaxN8ZKuYFPNXz0bnSzJgAx2QxbZTKQmCY9B3
        ZZgp0Fxwwjz30JxwPi/d4vbP9audLTX3msiLUI7d5b5Rgv/tMp2nREcT2MWk5SH9bMCXsPsWiCn
        qlkQMP7tAcCP9DpbyvJTg+g==
X-Received: by 2002:a0c:ab88:: with SMTP id j8mr6038035qvb.23.1621521416001;
        Thu, 20 May 2021 07:36:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTOpSjEbg1fjWhTkhhyfhExJ3Rsio6SZuqbobWYJDGavFY/5GmDdlgH8BmFdoZIVA5+IHf7A==
X-Received: by 2002:a0c:ab88:: with SMTP id j8mr6038021qvb.23.1621521415869;
        Thu, 20 May 2021 07:36:55 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v65sm2213356qkc.125.2021.05.20.07.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 07:36:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] fpga: generalize updating to partial and full
To:     Moritz Fischer <mdf@kernel.org>
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210519204256.1975957-1-trix@redhat.com>
 <YKV55XK1Py5YSXZp@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2e79a2f8-1917-b7f2-4b19-2a742ba0e28a@redhat.com>
Date:   Thu, 20 May 2021 07:36:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKV55XK1Py5YSXZp@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/19/21 1:49 PM, Moritz Fischer wrote:
> Tom,
>
> On Wed, May 19, 2021 at 01:42:56PM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> There is a need to update the whole card.
>> The user area, the shell and even the card firmware.
>> This needs to be handled differently than the
>> existing partial updating in the fpga manager.
>>
>> Move the write_* ops out of fpga_manager_ops and
>> into a new fpga_manager_update_ops struct.  Add
>> two update_ops back to fpga_manager_ops,
>> partial_update for the exiting functionality and
>> full_update for the new functionity.
> Partial and Full are somewhat loaded terms with FPGAs -- think partial
> reconfiguration vs full reconfiguration.
>
> How about 'persistent' and 'volatile' or something along those lines
> instead?

I think that only applies to xilinx,  its all persistent for dfl.

How about calling it what it is.

partial_update -> partial_reconfiguration

full_update -> board_reimage

Tom

> - Moritz
>

