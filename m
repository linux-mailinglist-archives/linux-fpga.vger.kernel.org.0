Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53582311DC0
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Feb 2021 15:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBFOiE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Feb 2021 09:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhBFOiD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Feb 2021 09:38:03 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385A8C061786
        for <linux-fpga@vger.kernel.org>; Sat,  6 Feb 2021 06:37:23 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id i20so9861444otl.7
        for <linux-fpga@vger.kernel.org>; Sat, 06 Feb 2021 06:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=dUta2SLkHo58mSd+Ytv5dpXjdkvjX7oW/nqsoEfffJdUhcuIoum5IUxdcCNL/hRt9p
         D48fV/z0cYeQzXsj/8Nl4H0IbyMFoi2mYXHRSCuP4EStO5YkEnPQZ5QC6rIhq+UeyL6D
         GNRXPTXnkHr+eCUpa1RmQyAda6st/8hIsXKCNL3dK2+jVl8B+1o/Q9x41vsrYxGj27fU
         3Cw478crGGL/5Ec2phUKlyVbognAQbvtvERa7kWRiyo9683VWgLQQjCtxEWy3fhdIHeR
         U4gtvkSyljBpOhOunXJfyXidW1YpE7CEuLizzDzkwf3U2itWoKuWsMGPmDzBZP6s4w7W
         NtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=HHJY0lBrXtFUH+e5D5dg4/Vjb97+bS0QRwttkRZwN9K6cONKjg9xkMsS2Kl2V8Kf0y
         vKvsRZ6sI86//EcQn2/7qM0wD6q+zJ75OPgO4GyFikeSfy5FKqTEcnO16hKUASqczqD1
         avwe8BcBpni0FMTVmUKx/6rNCPnZizrKX1iPbRUl1WaIeMmnfwiYo5CgkrNrySrmgx2i
         t1SWL6R9W9+2vttmE698mV0B9XlHc5Ki2uOiNCdGMReTZEOWGazP9LmrKtHS14Qys8VB
         sklgtcrtodWC/14MAFPlyhMWCAw+TLQI6qjWjqHrSZ2BORI/wiqUNDbfzCnSFAzwF3uH
         D6/g==
X-Gm-Message-State: AOAM533ViDqKYQau4Ng5YkldMJf/1nMzO0Df9ktroylxd1Fh8mYrcKPE
        1VLNayGt/BcK2NDUkcGajyc+beuXDxkynI5STYU=
X-Google-Smtp-Source: ABdhPJyyLqipzKwapuCKbLuF/yICIeC4eJFJszg+RIgGyuvqhT9h3dF4MzkvtTJIpj1zP86INZlTFILPkwiAKMpgJuw=
X-Received: by 2002:a9d:69cf:: with SMTP id v15mr7277615oto.122.1612622242714;
 Sat, 06 Feb 2021 06:37:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:37:22 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:37:22 +0100
Message-ID: <CAO_fDi-exGwWWDDdTG0V=E0m74yB2wzPK6vcWddkfnLCJz-PNA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
