Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8233DD04
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Mar 2021 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbhCPTBN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Mar 2021 15:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240256AbhCPTA7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Mar 2021 15:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615921257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+83Qg1vgEVFMO8aH5CDT+d7mix/CeixdY2c1lG5IW0E=;
        b=eTsy/84q7ye0lE8UmPgBU0/XRESr3pR7zHxMiF5N7qMRhcyo5AE5BD9pzxRj26Y9ZAef5K
        G0aFlMI5v6ymP73+2lsGgKzQxTtKy4fYN3bykmMtseIBvYojmfZRAVQflxgWtsYSetVo+k
        r0W6y1yobTHM0C7IjDTU+QXOapnPwi8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-jTclvNOTOMKAPUfAwlHiYQ-1; Tue, 16 Mar 2021 15:00:54 -0400
X-MC-Unique: jTclvNOTOMKAPUfAwlHiYQ-1
Received: by mail-qt1-f197.google.com with SMTP id b18so9880030qte.21
        for <linux-fpga@vger.kernel.org>; Tue, 16 Mar 2021 12:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=+83Qg1vgEVFMO8aH5CDT+d7mix/CeixdY2c1lG5IW0E=;
        b=DAQ+24RsSw87WajwI/j6FX2lOSgLcP1g5A3FaSw1xFemma6Cx1iyF4TZljKrH5ePCD
         LvYAC7DeNJDTVIyNst3YapM17Y20pxBrres4A4SDjn/sJiIzGYnl5D/PWPV4AwB7PXMN
         Ie5qsAu2Crzp3lsgiT70QVF6F+xllsDaHttGllHOr/aIwGgpCMPrNSZcbE0ZdyACqmtf
         +AJX6a1C5b2CXQ6i3yGtOR6x4kjSoLBNxsv0ssC5QHx06qL7WDOfrgUCblhDABuZziUa
         P478R+KZi6O/xjj42dA/Kn4dqI2VPSDeUhx5IxZAkxsjyfFssb930jsPnFwe9D65R4Vo
         R5Lw==
X-Gm-Message-State: AOAM530MVKHpD8+wVt23dkpSjyZo8ag6Bbkk9+AHHQ0wuoevun61n1iw
        4BYdQ7KFz64fwgUg48j6Gjjxl1+bf07BzECEmiIjO7D7XtoRozvDma+Eag80of9rMsgpn4LCYdp
        6O7BrRWLfYq3Pk58mjnqcLlTbmzGAbXSbRpl1RUNcm19ohTdIJjbrheUXocwiUO/c4+VA
X-Received: by 2002:a0c:e34d:: with SMTP id a13mr872525qvm.47.1615921253072;
        Tue, 16 Mar 2021 12:00:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBtS1dQwdXFPPEE78WntoicIoI8f7fklhccEwZc0BzWk8u7pgUFKAW7exJZqm7kIffyfxA6w==
X-Received: by 2002:a0c:e34d:: with SMTP id a13mr872457qvm.47.1615921252424;
        Tue, 16 Mar 2021 12:00:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p90sm14165745qtd.66.2021.03.16.12.00.51
        for <linux-fpga@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:00:51 -0700 (PDT)
To:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
From:   Tom Rix <trix@redhat.com>
Subject: LPC FPGA micro conference
Message-ID: <c56fddf0-dee0-845e-b214-78df9e9c8136@redhat.com>
Date:   Tue, 16 Mar 2021 12:00:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I am organizing a micro conf for the fpga subsystem.

The call for papers and proposals is out, here

https://linuxplumbersconf.org/

Tom

